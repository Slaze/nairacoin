#!/usr/bin/env bash
# Boot nairacoind offline and assert unique genesis. No spend keys.
set -euo pipefail

BIN="${1:-./build/bin/nairacoind}"
DATA="${2:-/tmp/ncn-boot-ci}"
EXPECTED_HASH="87510f172aee54e6a12b8147fd3fb65bd23794f3c6ff39dc3e32881406e9d4b7"
EXPECTED_TX="013c01ff0001ffffffffffff0302017bb117cce7ed6a238f75cca65eff600a7bedf37edd5f0f611a49cba609297c21010d2bca449c24215b92489cd1b17467ee68dbd1f324cb5af541e486a499d29491"

if [[ ! -x "$BIN" ]]; then
  echo "missing binary: $BIN" >&2
  exit 1
fi

rm -rf "$DATA"
mkdir -p "$DATA"

"$BIN" \
  --data-dir "$DATA" \
  --offline \
  --non-interactive \
  --no-zmq \
  --no-igd \
  --rpc-bind-ip 127.0.0.1 \
  --rpc-bind-port 18357 \
  --log-file "$DATA/nairacoin.log" \
  --log-level 1 &
PID=$!
cleanup() { kill "$PID" 2>/dev/null || true; wait "$PID" 2>/dev/null || true; }
trap cleanup EXIT

python3 - "$EXPECTED_HASH" "$EXPECTED_TX" <<'PY'
import json, sys, time, urllib.request

expected_hash, expected_tx = sys.argv[1], sys.argv[2]
last = None
info = None
for _ in range(90):
    try:
        with urllib.request.urlopen("http://127.0.0.1:18357/get_info", timeout=3) as r:
            info = json.loads(r.read().decode())
            break
    except Exception as e:
        last = e
        time.sleep(2)
if info is None:
    raise SystemExit("RPC never came up: %s" % last)

height = info.get("height")
top = info.get("top_block_hash")
if height != 1:
    raise SystemExit("expected get_info.height 1, got %r" % height)
if top != expected_hash:
    raise SystemExit("unexpected genesis hash %s" % top)

req = urllib.request.Request(
    "http://127.0.0.1:18357/json_rpc",
    data=json.dumps({"jsonrpc": "2.0", "id": "0", "method": "get_block", "params": {"height": 0}}).encode(),
    headers={"Content-Type": "application/json"},
)
with urllib.request.urlopen(req, timeout=10) as r:
    block = json.loads(r.read().decode())["result"]
blob = block.get("blob", "")
hdr = block["block_header"]
if expected_tx not in blob:
    raise SystemExit("GENESIS_TX missing from genesis blob")
if hdr.get("hash") != expected_hash:
    raise SystemExit("header hash mismatch")
if hdr.get("nonce") != 20260829:
    raise SystemExit("nonce mismatch: %r" % hdr.get("nonce"))
print("GENESIS_OK %s height=%s nonce=%s" % (expected_hash, height, hdr.get("nonce")))
PY

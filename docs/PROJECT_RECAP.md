# PROJECT_RECAP — nairacoin

## 2026-09-06 — CryptoNote genesis hex minted (this tree)

**Goal:** Fill empty `GENESIS_COINBASE_TX_HEX` so `nairacoind` can boot. Do not mix Monero blob. Do not replace GitHub `master`.

**What changed:**
- One-shot branch `print-genesis-once` + workflow `.github/workflows/print-genesis.yml`.
- GHA run `34034833056` success. Artifact `genesis-hex`.
- Hex pasted locally into `src/CryptoNoteConfig.h`. Comment: minted 2026-09-06 GHA 34034833056 — do not regenerate.

```
013c01ff0001ffffffffffff03029b2e4c0281c0b02e7c53291a94d1d0cbff8883f8024f5142ee494ffbbd0880712101edc6c12cac53a029cc4ba753c5dd5b115b12e497a1ecbdb4322df7dd4707a6ab
```

**Why:** Empty hex blocks boot. Mac binary is Linux ELF (exec format error). Colima down. Ubuntu-22.04 CI already builds.

**How verified:** Run conclusion success. Job log + artifact both print the same `const char GENESIS_COINBASE_TX_HEX[] = "..."` line. Header grep matches.

**Current state:** Hex + seed hostname in this tree, pushed to GitHub `master`. Do **not** merge `print-genesis-once` (one-shot workflow). `nairacoin.iconiaglobal.com` A `198.54.120.94` is Namecheap default webpage, TCP 17356 timeout. Shop still `https://slaze.github.io/nairacoin/` HTTP 200. Oracle signup blocked (card declined).

**Next steps (human):**
1. Host with public IPv4 + inbound TCP 17356. Point A `nairacoin.iconiaglobal.com` at that IPv4 (DNS only, not Cloudflare orange).
2. Clone `master`, build `nairacoind`, bind P2P `0.0.0.0:17356`, RPC `127.0.0.1:18357`.
3. Second seed later.
4. Do not re-run `--print-genesis-tx`. Do not merge `print-genesis-once`.

**Blockers / risks:** No daemon host. Regenerating hex forks the chain. RPC has no auth.

---

## 2026-09-02 — CryptoNote seeds + genesis attempt (this tree)

**Goal:** Point `SEED_NODES` at **nairacoin.iconiaglobal.com:17356** (not apex), keep `127.0.0.1:17356` local-dev, generate CryptoNote genesis on GitHub `master`.

**What changed:**
- `src/CryptoNoteConfig.h` — `SEED_NODES` = `nairacoin.iconiaglobal.com:17356`, `127.0.0.1:17356`. Comments: DNS **A** record, no invented IP, daemon must listen on TCP **17356**. `GENESIS_COINBASE_TX_HEX` still `""`.
- `docs/GENESIS.md` — this CryptoNote tree only (timestamp **0**, nonce **70**). Monero-tree blob stays on `~/nairacoin-monero-src` / `protocol-v0.18.5.1`; do not paste it here.

**Why:** Human asked for NairaCoin subdomain, not `iconiaglobal.com` apex. P2P port verified **17356**. This fork’s `Ipv4Resolver` needs an A record. Apex/Cloudflare HTTP IPs are the wrong target.

**How verified:** `dig +short A nairacoin.iconiaglobal.com` empty (no record yet). Apex/`ncn` resolve to Cloudflare `188.114.96.2` / `188.114.97.2` — **not** written into `SEED_NODES`. `P2P_DEFAULT_PORT` 17356 / `RPC_DEFAULT_PORT` 18357 in header. No git push.

**Current state:** Seed **names** are in source. Chain still not launched. `nairacoind --print-genesis-tx` not run here: cmake bottle download in progress; Boost not kegged; colima VM image downloading (docker was down). CI Linux build on `master` already succeeds (no artifact upload).

**Next steps (human):**
1. DNS **A**: `nairacoin.iconiaglobal.com` → IPv4 of the `nairacoind` host.
2. On Ubuntu: `sudo apt-get install -y build-essential cmake libboost-all-dev && cd ~/nairacoin && make -j$(nproc) && ./build/release/src/nairacoind --print-genesis-tx` → paste hex → rebuild.
3. Install/start `nairacoind` on that host, firewall **TCP 17356**, RPC **18357** localhost-only.
4. Do not push unless asked.

**Blockers / risks:** Hostname without A record + daemon = peers cannot join. `127.0.0.1` seed is useless for remote nodes. Empty hex still refuses boot. RPC has no auth.

---

## 2026-08-29 — unique genesis boots; protocol branch (Grok)

**Path:** protocol tree `/Users/ugoookogeri/nairacoin-monero-src`. GitHub `master` this repo stays 2016 CryptoNote + shop.

**Done:**
- Unique `GENESIS_TX` minted Linux; keys discarded.
- `nairacoind` 0.18.5.1-release offline boot: `get_info.height=1`, genesis hash `87510f172aee54e6a12b8147fd3fb65bd23794f3c6ff39dc3e32881406e9d4b7`, nonce `20260829`.
- Shop still HTTP 200 at `https://slaze.github.io/nairacoin/`.

**Verify:** docker `nairacoind --offline --non-interactive` + `/get_info` + `get_block` height 0.

**Next:** `protocol-v0.18.5.1` on GitHub. Do not replace `master` until that branch is live. Seed IPs still human.

---

## 2026-08-29 — gcc 11 build green (Grok)

**Path:** `/Users/ugoookogeri/nairacoin` (`https://github.com/Slaze/nairacoin`)

**Verify:** Actions `33258592044` success. Tip `aa25641`.

**Fixed:**
- Missing `<memory>` / std headers (`StdCompat.h` `-include`)
- Base58 fallthrough → byte loop
- `chacha8_key` memcpy onto destructor type
- `random_engine` min/max `constexpr`
- No throw in `cn_context` dtor
- sparsetable `string.h`
- P2P debug cmds off in Release
- Linux `EAGAIN == EWOULDBLOCK`
- Boost bind placeholders
- connectivity_tool link order (Serialization then Common)
- LTO off (dropped Common::read/write)

**Not done (human):**
- `GENESIS_COINBASE_TX_HEX` empty — run `nairacoind`, paste printed tx
- `SEED_NODES` empty
- Address prefix still `0x2` (`"f"`)
- RPC has no auth — do not expose to internet
- 2016 CryptoNote, not a modern privacy coin

**Next:** genesis + seed IPs. Then mine.

# NairaCoin genesis and seeds (this tree)

GitHub `master` / `~/nairacoin` is the **2016 CryptoNote** fork Lvfe talks to. One genesis story for this tree. Do **not** paste blobs from `~/nairacoin-monero-src` (Monero v0.18.5.1 identity fork, branch `protocol-v0.18.5.1`) into `src/CryptoNoteConfig.h`.

Copyright: The Cryptonote developers, MIT/X11 (header on `src/CryptoNoteConfig.h`).

## Identifiers (this fork)

| Field | Value | Where |
| --- | --- | --- |
| `CRYPTONOTE_NAME` | `nairacoin` | `src/CryptoNoteConfig.h` |
| Address prefix | `0x2` (`f…`) | same |
| Decimals | 8 | same |
| P2P / RPC | **17356** / **18357** | same |
| Genesis timestamp | **0** | `src/CryptoNoteCore/Currency.cpp` `generateGenesisBlock()` |
| Genesis nonce | **70** (71 if `--testnet`) | same |
| Genesis coinbase | `GENESIS_COINBASE_TX_HEX` | minted **2026-09-06** GHA `34034833056` — **do not regenerate** |
| Public seed | `nairacoin.iconiaglobal.com:17356` | `SEED_NODES` |
| Local-dev extra | `127.0.0.1:17356` | same list |

`--print-genesis-tx` uses a **zeroed** miner address plus a **random** tx extra key, so the hex is different every run. Paste **once**, rebuild, never regenerate if peers already exist.

## DNS (you)

Create at the `iconiaglobal.com` registrar (hostname only; do not invent an IP in git):

```
A    nairacoin.iconiaglobal.com    →    IPv4 of the machine running nairacoind
```

Not the apex `iconiaglobal.com`. Not `ncn.iconiaglobal.com` (shop window). This daemon resolves **IPv4 only**. Until the A record exists **and** `nairacoind` listens on **TCP 17356** (firewall open), `SEED_NODES` is only a name.

## Commands

Hex is already in `src/CryptoNoteConfig.h` (GHA `34034833056`). **Do not** run `--print-genesis-tx` again.

Linux x86_64 binary from CI (after green `Build Nairacoin` on `master`):
```bash
gh run download --repo Slaze/nairacoin --name nairacoind
sudo apt-get install -y libboost-all-dev libssl3
chmod +x nairacoind
```
Artifact is Ubuntu 22.04 x86_64. Not Mac. Not Ampere ARM.

Or build on the host:
```bash
cd ~/nairacoin
# Ubuntu: sudo apt-get install -y build-essential cmake libboost-all-dev
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --target Daemon -j"$(nproc)"
```

**Node 1 (seed)** on the host behind that A record:

```bash
./build/release/src/nairacoind \
  --data-dir "$HOME/.nairacoin" \
  --p2p-bind-ip 0.0.0.0 --p2p-bind-port 17356 \
  --rpc-bind-ip 127.0.0.1 --rpc-bind-port 18357 \
  --allow-local-ip
```

**Node 2:** same hex, `--add-exclusive-node nairacoin.iconiaglobal.com:17356` (or `127.0.0.1:17356` + `--allow-local-ip` on one machine).

## Other tree (do not mix)

`~/nairacoin-monero-src` minted a Monero-style genesis (nonce `20260829`, hash `87510f172aee54e6a12b8147fd3fb65bd23794f3c6ff39dc3e32881406e9d4b7`). That is **not** this CryptoNote coinbase. Keep it on `protocol-v0.18.5.1`.

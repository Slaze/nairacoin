# PROJECT_RECAP — nairacoin Monero rebase

## 2026-08-29 — unique genesis boots (Grok)

**Path:** `/Users/ugoookogeri/nairacoin-monero-src` (Monero v0.18.5.1 pin `4f92268`). GitHub `master` still 2016 CryptoNote + shop.

**Done:**
- Unique `GENESIS_TX` minted Linux; keys discarded (unspendable premine).
- `nairacoind` built in `nairacoin-build` (Ubuntu 22.04 / Colima aarch64).
- Offline boot: height 1, genesis hash `87510f172aee54e6a12b8147fd3fb65bd23794f3c6ff39dc3e32881406e9d4b7`, nonce `20260829`.
- Shop window kept on GitHub Pages (`shop/`). Not a BTC peg.

**Verify:**
- `nairacoind --offline --non-interactive` log: `HEIGHT 0` + unique hash.
- `get_info.height == 1`, `top_block_hash` matches genesis.
- Genesis blob contains `013c01ff0001ffffffffffff0302017bb117…`.

**Not done:**
- Seed IPs empty until human VPS.
- GitHub `master` not replaced.
- DNS CNAME `ncn.iconiaglobal.com` is human.
- RPC has no auth — do not expose.
- Log still says Monero product string; precomputed Monero hashes still load (sync shortcut only).

**Next:** protocol branch on GitHub. Shop stays on `master`. Two seed VPS. Then decide master swap.

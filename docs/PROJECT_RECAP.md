# PROJECT_RECAP — nairacoin

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

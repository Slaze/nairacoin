# PROJECT_RECAP — nairacoin

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

# PROJECT_RECAP — nairacoin

## 2026-08-25 — compile + security gate (Grok)

**Path:** `/Users/ugoookogeri/nairacoin` (clone of https://github.com/Slaze/nairacoin)

**Goal:** Audit + fix so master builds. Token-tight; no genesis rewrite.

**Symptom:** GitHub Actions `Build Nairacoin` failed (`run 32533580989`). gcc 11 + `-Werror`.

**Root cause:**
1. `include/INode.h` / `src/CryptoNoteCore/ICore.h` use `std::unique_ptr` without `#include <memory>`. Parser dies; `getPoolSymmetricDifference` looks like 4-arg.
2. Intentional Base58 fallthrough treated as error.
3. `memcpy` onto `chacha8_key` (has destructor) → `-Werror=class-memaccess`.

**Changes:**
- `#include <memory>` (and `<functional>` in ICore.h)
- Base58 `/* fall through */`
- `generate_chacha8_key` copies `key.data` only
- gcc 7–11 `-Wno-error=` for old CryptoNote vs modern gcc
- `ALLOW_DEBUG_COMMANDS` only when `NDEBUG` unset (Release off)

**Verify:** `clang++ -std=c++11 -fsyntax-only` on `INode.h` + `ICore.h`. Full daemon build **not** run here (no local cmake). Push to GitHub to re-run Actions.

**Not done (human):**
- `GENESIS_COINBASE_TX_HEX` still `""` — first daemon print, then paste
- `SEED_NODES` empty
- Address prefix still `0x2` (comment says `"f"`)
- 2016 CryptoNote RPC has no auth; do not expose RPC to internet

**Next:** commit + push; confirm Actions green; generate genesis; add seed IPs.

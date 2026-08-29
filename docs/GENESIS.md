# Unique genesis (minted Linux 2026-08-29)

Built `nairacoin-gen-genesis` in Ubuntu 22.04 (Colima). Keys discarded. Genesis miner output is **unspendable** (no premine).

```
013c01ff0001ffffffffffff0302017bb117cce7ed6a238f75cca65eff600a7bedf37edd5f0f611a49cba609297c21010d2bca449c24215b92489cd1b17467ee68dbd1f324cb5af541e486a499d29491
```

Nonce mainnet `20260829`. Not the Monero genesis blob.

## Boot proof (`nairacoind` 0.18.5.1-release, `--offline`)

| Field | Value |
|---|---|
| `get_info.height` | 1 (next height; genesis is 0) |
| genesis hash | `87510f172aee54e6a12b8147fd3fb65bd23794f3c6ff39dc3e32881406e9d4b7` |
| genesis PoW | `3891e2b412781abed4eadf5da876270936cc89356037d06b75a78752ef5c27ad` |
| miner_tx_hash | `1e2f20b09cd6957fcc839fcf0a07f2119e244bdb5c5907da0b9f7b31e044321a` |
| nonce | `20260829` |
| nettype | mainnet |
| difficulty | 1 |

Blob contains the unique `GENESIS_TX`. Not Monero genesis (`418015bb9ae982a1975da7d79277c2705727a56894ba0fb246adaabb1f4632e3`).

Source tree: `~/nairacoin-monero-src` (Monero v0.18.5.1 identity fork). GitHub `master` stays 2016 CryptoNote + shop until this branch is adopted.

Do not print or commit genesis spend keys. Keys were discarded at mint.

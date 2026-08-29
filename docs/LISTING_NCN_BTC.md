# NCN/BTC listing — what “ensure” actually means

**Nobody can guarantee a CEX listing.** Binance, Kraken, TradeOgre, XeggeX, NonKYC decide. Code cannot force them.

**Your $10 BTC** is opening inventory on a book **after** a venue exists. It does not get you listed. It does not peg NCN to Bitcoin. It is the most BTC a seller can take from your quote until you add more.

NCN is **not** BTC-backed.

## Two paths

### A. Venue listing (not guaranteed)

What they check:

1. Live unique chain (not XMR, not a copy-paste genesis).
2. Two public seed nodes that stay up.
3. `nairacoind` + `nairacoin-wallet-rpc` they can run or hit.
4. Explorer (block + tx lookup).
5. Unique ticker **NCN**, unique ports, unique `NETWORK_ID`.
6. You are reachable. Listing fee if they charge one.
7. **Liquidity:** they want you to seed NCN/BTC. ~$10 is a start; thin. Add more if you want the pair to survive one sell.

Packet to send (after genesis exists):

- Ticker, supply rule, genesis hash, `NETWORK_ID`
- Seed IPs:ports (17356)
- Wallet RPC docs
- Explorer URL
- Git tag / commit of `nairacoind`
- Statement: not a BTC peg; NCN/BTC is a market pair

Apply to **several small BTC-pair venues at once**. One yes is enough. Silence for weeks is normal. “No” is final for that shop.

### B. You host the pair (how you actually ensure a market)

**Yes, it can live on a subdomain of iconiaglobal.com** if you control that DNS. Example: `ncn.iconiaglobal.com` or `book.iconiaglobal.com`.

DNS: A/AAAA (or CNAME) to the box that serves the book. TLS (Let's Encrypt). Reverse proxy (Caddy/nginx) to the app. Same site cookies: keep the book on its own host, do not share session with the marketing site.

**Warning:** Hosting a venue that matches NCN to BTC can be treated as running an exchange / money transmission in some countries. That is a legal question for you, not a DNS question. DNS does not make it legal.

A subdomain is branding + HTTPS. It does not list you on TradeOgre. It does not make NCN worth BTC.

If no CEX lists, **you still have an NCN/BTC market if you run it:**

1. You hold NCN (mined) and ~$10 BTC.
2. You publish two-sided quotes (bid and ask in BTC per NCN).
3. Settlement: BTC on-chain or Lightning to your address; NCN via wallet-rpc. Manual first is fine.
4. Later: atomic-swap stack (BasicSwap is XMR–BTC; NCN fork is extra work).

That is a real pair. Tiny. Honest. Under your control.

Do not:

- Put $10 in a wallet and advertise “backed by Bitcoin.”
- Hardcode a BTC price in the daemon.
- Promise Binance.

## What can make money (and what cannot)

Not financial advice. Facts:

| Piece | Profit? |
|-------|---------|
| BTC you hold | That is the BTC bet. NCN is unrelated. If you think BTC rips, holding BTC is the direct trade. |
| $10 on NCN/BTC book | Inventory, not income. Max loss ~$10 if NCN goes to zero vs BTC. Spread you earn is tiny until volume exists. |
| CEX listing | Cost (time, maybe fee). You profit only if someone buys NCN from you above your basis. Listing is not a payday. |
| Self-hosted book on iconiaglobal.com | You keep the spread if people trade. No traders = $0. Domain only helps if that site already has users who want NCN. |
| Mining NCN | Worthless until a buyer. Block reward is not USD. |
| Claiming NCN is “tied to BTC” | Not profit. Misleading. Do not. |

**Only profitable path:** people pay BTC for NCN because they want NCN. The book is plumbing. iconiaglobal.com is a shop window if you already have traffic.

## Order of work (do not skip)

1. Monero-grade `nairacoind` live, unique genesis, two seeds.
2. Mine. Prove a spend.
3. Listing packet (this file, filled in).
4. Apply to small venues **and** stand up your own $10 two-sided quote so a print exists even if they say no.
5. If a venue lists: deposit NCN + that BTC there instead (or as well).

## Fill in after genesis (not yet)

| Field | Value |
|-------|--------|
| Ticker | NCN |
| P2P | 17356 |
| RPC | 18357 |
| Genesis miner tx | `013c01ff0001ffffffffffff0302017bb117cce7ed6a238f75cca65eff600a7bedf37edd5f0f611a49cba609297c21010d2bca449c24215b92489cd1b17467ee68dbd1f324cb5af541e486a499d29491` (keys discarded, unspendable) |
| NETWORK_ID | TBD |
| Seeds | TBD (your VPS IPs) |
| Explorer | TBD |

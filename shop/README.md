# NCN/BTC shop window

Live target after Pages: `https://slaze.github.io/nairacoin/` then CNAME `ncn.iconiaglobal.com`.

Static bureau ticket. Serve `index.html` at `ncn.iconiaglobal.com`.

## DNS (you)

1. At the registrar for `iconiaglobal.com`, add:
   - `CNAME ncn` → GitHub Pages host **or** your VPS hostname
2. If GitHub Pages: repo Settings → Pages → `/shop` or deploy this folder. This `CNAME` file is the Pages custom domain.
3. HTTPS: Pages does it; a VPS needs Caddy/nginx + Let's Encrypt.

Quotes stay `TBD` until unique genesis + a funded BTC address.

Not a peg. Opening book ~$10 BTC after the chain lives.

# Nairacoin shop / wallet PWA

Installable window for **Nairacoin (NCN)** — status, wallet explainer, Get NCN (via Lvfe), and NCN/BTC bureau ticket.

## Live targets

- GitHub Pages: `https://slaze.github.io/nairacoin/` (deployed from this `shop/` folder via `.github/workflows/shop-pages.yml`)
- Custom domain: `https://ncn.iconiaglobal.com/` — DNS must be **CNAME `ncn` → `slaze.github.io`** (or Pages hostname), **not** orange-clouded to Namecheap default webpage.
- Daemon hostname stays separate: `nairacoin.iconiaglobal.com` → real VPS when seeds exist.

## Contents

- `index.html` — Home / Status / Wallet / Get / Bureau
- `manifest.webmanifest` + `sw.js` + `icons/` — PWA install
- `CNAME` — `ncn.iconiaglobal.com` for Pages custom domain

## Get NCN

v1 deep-links to Lvfe Wallet Buy:

`https://iconiaglobal.com/lvfe/?play=1&hub=wallet`

No second Paystack merchant on this domain.

## DNS (human)

1. Cloudflare DNS for `iconiaglobal.com`: `CNAME ncn` → `slaze.github.io` (DNS only or proxied per Pages docs; Pages custom domain must be verified).
2. Remove any A record that sends `ncn` to `198.54.120.94` (that serves cPanel default page).
3. Repo Settings → Pages → custom domain `ncn.iconiaglobal.com` + HTTPS.

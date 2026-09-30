# farsarakis-cv — personal website

Minimal, static academic homepage (single `index.html`, no build step) served via GitHub Pages
at **farsarakis.com**.

## Files
- `index.html` — the whole site (inline CSS + a tiny theme toggle)
- `resume.pdf`, `resume-2page.pdf` — downloadable CV
- `CNAME` — custom domain (`farsarakis.com`); GitHub Pages reads this automatically
- `.nojekyll` — serve files as-is (skip Jekyll)

## Preview locally
Open `index.html` in a browser, or:
```
cd website && python3 -m http.server 8000   # then visit http://localhost:8000
```

## Publish to GitHub Pages (run on your Mac, with gh authenticated)
```
cd website
git init && git add -A && git commit -m "Initial academic site"
gh repo create farsarakis-cv --public --source=. --remote=origin --push
```
Then enable Pages (Settings → Pages → Build and deployment → Deploy from a branch → `main` / `root`),
or via CLI:
```
gh api -X POST repos/<your-username>/farsarakis-cv/pages -f 'source[branch]=main' -f 'source[path]=/'
```
The site goes live at `https://<your-username>.github.io/farsarakis-cv/` first; the custom domain
takes over once DNS is set. After the domain resolves, tick **Enforce HTTPS** in Settings → Pages.

## DNS (Cloudflare, since Sep 2026)
Registrar is still names.co.uk; nameservers point at Cloudflare (`elisabeth` / `stanley .ns.cloudflare.com`).
Origin is still GitHub Pages. Records in the Cloudflare zone:
```
A      @      185.199.108.153 / .109.153 / .110.153 / .111.153   (proxied)
CNAME  www    efarsarakis.github.io                              (proxied)
MX     @      30 fwd0/fwd1/fwd2.hosts.co.uk   (names.co.uk mail forwarding, legacy)
TXT    @      google-site-verification=...
```
Settings: SSL/TLS mode **Full** (not *strict*: GitHub's own cert renewal can fail behind a proxy, and
strict would then 526), **Always Use HTTPS** on. GitHub Pages keeps `Enforce HTTPS` and the `CNAME`
file (`www.farsarakis.com`); apex → www is GitHub's 301.

Verify with `dig NS farsarakis.com +short` and `curl -sIL https://farsarakis.com/`.

<details>
<summary>Previous setup: DNS at names.co.uk</summary>

Apex `farsarakis.com` — four **A** records (host `@` or blank):
```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```
`www` — one **CNAME** record → `<your-username>.github.io`

(Optional IPv6 — four **AAAA** records on `@`: `2606:50c0:8000::153`, `8001::153`, `8002::153`, `8003::153`.)

DNS can take up to ~24 h to propagate. Verify with `dig farsarakis.com +short`.
</details>

## Updating the CV PDFs
Re-export from the LaTeX project and copy the new `resume.pdf` / `resume-2page.pdf` here, then
`git commit` + `git push`.

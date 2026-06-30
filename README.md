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

## DNS at names.co.uk (Manage Domain → Advanced DNS / DNS records)
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

## Updating the CV PDFs
Re-export from the LaTeX project and copy the new `resume.pdf` / `resume-2page.pdf` here, then
`git commit` + `git push`.

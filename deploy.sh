#!/usr/bin/env bash
# Deploy the site: commit, sync with remote, push. GitHub Pages redeploys in ~1-2 min.
# Usage: ./deploy.sh "commit message"   (message optional)
set -e
cd "$(dirname "$0")"

msg="${1:-Update site}"

# Clear any stuck git lock left by Google Drive sync
rm -f .git/*.lock .git/objects/*.lock 2>/dev/null || true

git add -A
git commit -m "$msg" || echo "(nothing new to commit)"

# Bring in any remote changes (e.g. GitHub's CNAME tweaks) before pushing
if ! git pull --rebase origin main; then
  echo
  echo "!! Rebase hit a conflict. Resolve it, then run:  git rebase --continue && git push"
  echo "   (If it's the CNAME file, both sides are www: printf 'www.farsarakis.com\\n' > CNAME && git add CNAME && GIT_EDITOR=true git rebase --continue && git push)"
  exit 1
fi

git push
echo
echo "Pushed. GitHub Pages will rebuild in ~1-2 min — check the Actions tab, then hard-refresh (Cmd+Shift+R)."

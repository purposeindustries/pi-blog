#!/bin/bash
rm -rf out || exit 0;
node_modules/docpad/bin/docpad --silent generate
( cd out
  git init
  git config user.name "Travis-CI"
  git config user.email "dev@purposeindustries.co"
  git add .
  git commit -m "Deployed to Github Pages"
  git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages >/dev/null
)

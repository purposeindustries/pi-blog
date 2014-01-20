#!/bin/bash

# remove garbage
rm -rf out || exit 0;

# build site
node_modules/docpad/bin/docpad --silent generate

# do not deploy other branches
if [[ $TRAVIS_BRANCH != "master" ]]
then
  echo "Skip deploy on branch $TRAVIS_BRANCH ...";
  exit 0;
fi

# deploy *all* the things
( cd out
  git init
  git config user.name "Travis-CI"
  git config user.email "dev@purposeindustries.co"
  cp ../CNAME ./CNAME
  git add .
  git commit -m "Deployed to Github Pages"
  git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages >/dev/null 2>&1
)

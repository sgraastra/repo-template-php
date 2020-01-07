#!/bin/sh

git remote add repo-template-php git@github.com:studyportals/repo-template-php.git
git fetch --quiet repo-template-php

currentRevision=$(git rev-parse --remotes=repo-template-php)

if [ -f .github/repo-template/revision ]; then
   usedRevision=$(cat .github/repo-template/revision)

  if [ "$currentRevision" != "$usedRevision" ]; then
    git stash --quiet --include-untracked
    git diff "$usedRevision"..repo-template-php/master | git apply
    git add .
    git commit -e -m "Merge branch 'repo-template-php/master' into Woei" -m "Repository was at $usedRevision now at $currentRevision"
    git stash pop --quiet
  fi

else
   echo "$currentRevision" > .github/repo-template/revision
fi

git remote remove repo-template-php

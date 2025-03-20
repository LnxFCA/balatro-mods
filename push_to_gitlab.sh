#!/usr/bin/env bash

BRANCH="${1:-release}"

if [ "$BRANCH" = "main" ]
then
  git subtree push --prefix=common shared-gitlab main:main
  git subtree push --prefix=first-round-joker frjm-gitlab main:main
  git subtree push --prefix=lock-the-deal ltdm-gitlab main:main
  git subtree push --prefix=hermit-level-up hlum-gitlab main:main
else
  git subtree push --prefix=common shared-gitlab gitlab-release:release
  git subtree push --prefix=first-round-joker frjm-gitlab gitlab-release:release
  git subtree push --prefix=lock-the-deal ltdm-gitlab gitlab-release:release
  git subtree push --prefix=hermit-level-up hlum-gitlab gitlab-release:release
fi

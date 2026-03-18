#!/usr/bin/env zsh

git config filter.strip-api-keys.clean './strip-api-keys'
git config filter.strip-api-keys.smudge cat
echo "Git filters installed."

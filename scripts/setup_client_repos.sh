#!/bin/bash
# Script to add all client repositories as git remotes
CLIENTS=(
    "Zius-Global ZENVR"
    "dt-uk DENVR"
    "qb-eu QENVR"
    "vipul-zius ZENVR"
    "mike-aeq AENVR"
)
for client in "${CLIENTS[@]}"; do
    read -r org repo <<< "$client"
    git remote add "${repo,,}" "https://github.com/${org}/${repo}.git"
    echo "Added remote: ${repo,,} -> ${org}/${repo}"
done
git remote -v

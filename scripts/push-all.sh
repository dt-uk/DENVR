#!/bin/bash

# Nullstellensatz Project - Push to all repositories
# This script pushes the project to all client repositories

set -e

echo "Nullstellensatz Project - Multi-Repository Push"
echo "==============================================="

# Function to push to repository
push_to_repo() {
    local repo_name=$1
    local remote_url=$2
    local branch_name=$3
    
    echo ""
    echo "Processing: $repo_name"
    echo "Remote: $remote_url"
    echo "Branch: $branch_name"
    
    # Check if remote exists, add if not
    if ! git remote | grep -q "^${repo_name}$"; then
        echo "Adding remote: $repo_name"
        git remote add $repo_name $remote_url
    fi
    
    # Create and switch to branch
    git checkout -b $branch_name 2>/dev/null || git checkout $branch_name
    
    # Add all files
    git add .
    
    # Commit
    git commit -m "Add Nullstellensatz implementation for $repo_name" || true
    
    # Push to remote
    echo "Pushing to $repo_name/$branch_name..."
    git push $repo_name $branch_name --force
    
    echo "✓ Successfully pushed to $repo_name"
}

# Main script
echo "Starting multi-repository push..."
echo ""

# Save current branch
CURRENT_BRANCH=$(git branch --show-current)

# List of repositories and their branches
declare -A repositories=(
    ["ZENVR"]="git@github.com:Zius-Global/ZENVR.git"
    ["DENVR"]="git@github.com:dt-uk/DENVR.git"
    ["QENVR"]="git@github.com:qb-eu/QENVR.git"
    ["ZENVR_vipul"]="git@github.com:vipul-zius/ZENVR.git"
    ["AENVR"]="git@github.com:mike-aeq/AENVR.git"
    ["BENVR"]="git@github.com:manav2341/BENVR.git"
)

declare -A shellworlds_repos=(
    ["shellworlds_ZENVR"]="git@github.com:shellworlds/ZENVR.git"
    ["shellworlds_DENVR"]="git@github.com:shellworlds/DENVR.git"
    ["shellworlds_QENVR"]="git@github.com:shellworlds/QENVR.git"
    ["shellworlds_AENVR"]="git@github.com:shellworlds/AENVR.git"
    ["shellworlds_BENVR"]="git@github.com:shellworlds/BENVR.git"
    ["origin"]="git@github.com:shellworlds/ENVR.git"
)

# Push to main repositories
for repo in "${!repositories[@]}"; do
    branch_name="${repo}42"
    push_to_repo "$repo" "${repositories[$repo]}" "$branch_name"
done

# Push to shellworlds backup repositories
for repo in "${!shellworlds_repos[@]}"; do
    branch_name="main"
    if [[ "$repo" == "origin" ]]; then
        branch_name="main"
    else
        branch_name="${repo}_backup"
    fi
    push_to_repo "$repo" "${shellworlds_repos[$repo]}" "$branch_name"
done

# Return to original branch
git checkout $CURRENT_BRANCH

echo ""
echo "==============================================="
echo "All repositories pushed successfully!"
echo ""
echo "Summary of pushed repositories:"
echo "-------------------------------"
echo "Client Repositories:"
for repo in "${!repositories[@]}"; do
    echo "  - $repo: Branch '${repo}42'"
done
echo ""
echo "Backup Repositories:"
for repo in "${!shellworlds_repos[@]}"; do
    branch="main"
    if [[ "$repo" != "origin" ]]; then
        branch="${repo}_backup"
    fi
    echo "  - $repo: Branch '$branch'"
done

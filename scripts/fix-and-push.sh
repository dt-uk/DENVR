#!/bin/bash

# Fix git state and push everything properly

echo "=== Fixing Git State and Pushing ==="

# Check current state
echo "Current branch: $(git branch --show-current)"
echo "Git status:"
git status --short

# Ensure we're on main
git checkout main 2>/dev/null || git checkout -b main

# Add all changes
git add .

# Commit if there are changes
if ! git diff --cached --quiet; then
    git commit -m "Final fixes and updates for all client repositories"
fi

# Push to all remotes with proper branch detection
for remote in $(git remote); do
    echo ""
    echo "Processing remote: $remote"
    
    # Determine branch based on remote name
    branch="main"
    if [[ $remote == *"ZENVR"* ]] || [[ $remote == *"zenvr"* ]]; then
        branch="ZENVR44"
    elif [[ $remote == *"DENVR"* ]] || [[ $remote == *"denvr"* ]]; then
        branch="DENVR44"
    elif [[ $remote == *"QENVR"* ]] || [[ $remote == *"qenvr"* ]]; then
        branch="QENVR44"
    elif [[ $remote == *"AENVR"* ]] || [[ $remote == *"aenvr"* ]]; then
        branch="AENVR44"
    elif [[ $remote == *"BENVR"* ]] || [[ $remote == *"benvr"* ]]; then
        branch="BENVR44"
    elif [[ $remote == *"ENVR"* ]] || [[ $remote == *"envr"* ]]; then
        branch="ENVR44"
    fi
    
    echo "Pushing to $remote/$branch"
    
    # Try to push main first
    if git push "$remote" main --force-with-lease 2>/dev/null; then
        echo "  ✓ Pushed main to $remote"
    else
        echo "  ⚠ Could not push main to $remote"
    fi
    
    # Also push specific branch if different
    if [[ "$branch" != "main" ]]; then
        # Ensure the branch exists locally
        if git show-ref --verify --quiet "refs/heads/$branch" 2>/dev/null; then
            git checkout "$branch" 2>/dev/null
            git push "$remote" "$branch" --force-with-lease 2>/dev/null && echo "  ✓ Pushed $branch to $remote" || echo "  ⚠ Could not push $branch to $remote"
            git checkout main 2>/dev/null
        fi
    fi
done

echo ""
echo "=== Push Complete ==="

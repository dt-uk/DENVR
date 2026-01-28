#!/bin/bash

Collaboration Setup Script for Project SLK6
This script helps collaborators get started with their repositories
set -e

echo "=== Project SLK6 - Collaborator Setup ==="
echo ""

Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
echo "GitHub CLI not found. Installing..."
if [[ "$(uname)" == "Linux" ]]; then
    sudo apt-get update
    sudo apt-get install -y gh
    
elif [[ "$(uname)" == "Darwin" ]]; then
    brew install gh
    
else
    echo "Please install GitHub CLI manually: https://cli.github.com"
    exit 1
fi
fi

Check authentication
echo "Checking GitHub authentication..."
if ! gh auth status &> /dev/null; then
echo "Please authenticate with GitHub CLI:"
gh auth login
fi

Display collaborator options
echo ""
echo "Select your collaborator role:"
echo "1) muskan-dt - DENVR repositories"
echo "2) mike-aeq - AENVR repositories"
echo "3) vipul-zius - ZENVR repositories"
echo "4) manav-2341 - BENVR repositories"
echo "5) Other collaborator"
echo ""
read -p "Enter choice (1-5): " role_choice

case $role_choice in
1)
REPO_OWNER="dt-uk"
REPO_NAME="DENVR"
BRANCH="DENVR44"
BACKUP_REPO="shellworlds/DENVR"
COLLAB_EMAIL="muskan.s@data-t.space"
;;
2)
REPO_OWNER="shellworlds"
REPO_NAME="AENVR"
BRANCH="AENVR44"
BACKUP_REPO="mike-aeq/AENVR"
COLLAB_EMAIL="mike.s@a-eq.com"
;;
3)
REPO_OWNER="shellworlds"
REPO_NAME="ZENVR"
BRANCH="ZENVR44"
BACKUP_REPO="vipul-zius/ZENVR"
COLLAB_EMAIL="vipul.j@zi-us.com"
;;
4)
REPO_OWNER="shellworlds"
REPO_NAME="BENVR"
BRANCH="BENVR44"
BACKUP_REPO="manav2341/BENVR"
COLLAB_EMAIL="crm@borelsigma.in"
;;
5)
read -p "Enter repository owner (e.g., shellworlds): " REPO_OWNER
read -p "Enter repository name (e.g., ENVR): " REPO_NAME
read -p "Enter branch name: " BRANCH
read -p "Enter your email: " COLLAB_EMAIL
BACKUP_REPO=""
;;
*)
echo "Invalid choice. Exiting."
exit 1
;;
esac

echo ""
echo "=== Setup Configuration ==="
echo "Primary Repository: $REPO_OWNER/$REPO_NAME"
echo "Branch: $BRANCH"
echo "Email: $COLLAB_EMAIL"
if [ -n "$BACKUP_REPO" ]; then
echo "Backup Repository: $BACKUP_REPO"
fi
echo ""

Clone the repository
echo "Cloning repository..."
git clone -b $BRANCH "git@github.com:$REPO_OWNER/$REPO_NAME.git" "SLK6-$REPO_NAME"
cd "SLK6-$REPO_NAME"

Configure git identity
git config user.email "$COLLAB_EMAIL"
git config user.name "$(git config user.name)"

Run setup
echo ""
echo "Running project setup..."
chmod +x scripts/setup.sh
./scripts/setup.sh

Create initial collaborator commit
echo ""
echo "Creating initial collaborator setup..."
cat > COLLABORATOR_SETUP.md << 'COLLABDOC'

Collaborator Setup - $(date +%Y-%m-%d)
Collaborator: $(git config user.name)
Email: $(git config user.email)
Repository: $REPO_OWNER/$REPO_NAME
Branch: $BRANCH
Setup Date: $(date)

Environment
OS: $(uname -s)

Git: $(git --version | head -n1)

Python: $(python3 --version 2>/dev/null || echo "Not installed")

Node: $(node --version 2>/dev/null || echo "Not installed")

Next Steps
Review the project structure

Run verification: ./scripts/verify.sh

Check API server: node src/node/server.js

Review documentation at docs/index.html
COLLABDOC

git add COLLABORATOR_SETUP.md
git commit -m "Initial collaborator setup for $(git config user.name)"
git push origin $BRANCH

echo ""
echo "=== Setup Complete ==="
echo "Repository: SLK6-$REPO_NAME"
echo "Branch: $BRANCH"
echo ""
echo "Next steps:"
echo "1. Review the project structure"
echo "2. Run: ./scripts/verify.sh"
echo "3. Check API: node src/node/server.js"
echo "4. Open documentation: open docs/index.html"
echo ""
echo "For collaboration guidelines, see docs/collaboration/collaborators.md"

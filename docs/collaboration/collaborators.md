# Collaborator Management - Project SLK6

## Primary Collaborators

### 1. muskan-dt (Muskan S)
- **Repository**: dt-uk/DENVR
- **Email**: muskan.s@data-t.space
- **Access**: Write permissions to DENVR repository
- **Branch**: DENVR44
- **Responsibilities**: 
  - Review and merge pull requests
  - Maintain DENVR implementation
  - Coordinate with dt-uk team

### 2. mike-aeq (Mike S)
- **Repository**: shellworlds/AENVR (and mike-aeq/AENVR)
- **Email**: mike.s@a-eq.com
- **Access**: Write permissions to AENVR repositories
- **Branch**: AENVR44
- **Responsibilities**:
  - AENVR project management
  - Technical oversight
  - Client communication

### 3. vipul-zius (Vipul J)
- **Repository**: shellworlds/ZENVR (and vipul-zius/ZENVR)
- **Email**: vipul.j@zi-us.com
- **Access**: Write permissions to ZENVR repositories
- **Branch**: ZENVR44
- **Responsibilities**:
  - ZENVR implementation lead
  - Code review and quality assurance
  - Zius-Global liaison

### 4. manav-2341 (Manav)
- **Repository**: shellworlds/BENVR (and manav2341/BENVR)
- **Email**: crm@borelsigma.in
- **Access**: Write permissions to BENVR repositories
- **Branch**: BENVR44
- **Responsibilities**:
  - BENVR project coordination
  - Business requirements mapping
  - Client support

## Access Setup Commands

### For Repository Owners (run once per repo):
```bash
# Add collaborator to repository (GitHub UI or API)
# GitHub CLI commands:
gh repo collaborator add <username> --repo <owner>/<repo> --permission write

# Example for muskan-dt on dt-uk/DENVR:
# gh repo collaborator add muskan-dt --repo dt-uk/DENVR --permission write
# Clone the specific branch
git clone -b <branch_name> git@github.com:<owner>/<repo>.git

# Example for muskan-dt:
git clone -b DENVR44 git@github.com:dt-uk/DENVR.git
cd DENVR
Collaboration Workflow
Initial Setup:

Collaborators clone their respective branch

Run setup script: ./scripts/setup.sh

Development:

Work on feature branches

Regular commits with descriptive messages

Push to remote feature branches

Code Review:

Create Pull Requests to main branch

Request reviews from other collaborators

Address feedback and update PR

Deployment:

Merge approved PRs

Update documentation

Run verification scripts

Communication Channels
GitHub Issues: Feature requests and bug tracking

Pull Requests: Code review and discussion

Email: Formal communications and approvals

Project Boards: Task tracking (GitHub Projects)

Security Notes
Never commit sensitive data (API keys, passwords)

Use environment variables for configuration

Regular dependency updates

Code scanning enabled on all repositories

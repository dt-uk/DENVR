# M-DOD: Multi-Domain Operations Dashboard - Installation
## One-Command Deployment for All Platforms

### Prerequisites
- **Linux (Ubuntu 22.04+)**: Docker, 32GB RAM, 1TB SSD
- **Mac (Apple Silicon)**: Docker Desktop, 16GB+ RAM
- **Windows**: WSL2 with Ubuntu, Docker Desktop

### Quick Start (All Platforms)
```bash
# 1. Clone the repository
git clone -b ZENVR16 https://github.com/Zius-Global/ZENVR.git mdod
cd mdod

# 2. Run system check
./system_check/mdod_system_monitor.sh

# 3. Deploy with one command
./scripts/deploy_orchestrate.sh
Platform-Specific Notes
Linux/Ubuntu (Recommended):

bash
# Install all dependencies
sudo apt update && sudo apt install -y git docker.io
Mac (Apple Silicon):

bash
# Ensure Docker Desktop is running
arch -arm64 brew install docker
Windows (WSL2):

powershell
# In PowerShell as Administrator
wsl --install -d Ubuntu
# Then follow Linux instructions inside WSL
Verification
Access these services after deployment:

Dashboard: http://localhost:8080

API Gateway: http://localhost:3000

AI Fusion API Docs: http://localhost:8000/docs

Health Check: http://localhost:3000/health

Troubleshooting
Port conflicts: Modify ports in docker/mdod-compose.yml

Permission denied: Run sudo usermod -aG docker $USER and logout/login

Memory issues: Ensure 32GB RAM available for optimal performance

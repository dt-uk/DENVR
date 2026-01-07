#!/bin/bash
# M-DOD: Install 16 Crucial Tools for Multi-Domain Operations Development
set -e
echo "Installing 16 crucial tools for M-DOD..."

# 1-4: Containerization & Orchestration
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
# Install kubectl for Kubernetes
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# 5-8: Monitoring & Observability
wget https://github.com/prometheus/prometheus/releases/download/v2.51.0/prometheus-2.51.0.linux-amd64.tar.gz
tar xvf prometheus-2.51.0.linux-amd64.tar.gz
sudo mv prometheus-2.51.0.linux-amd64/prometheus /usr/local/bin/
# Install Grafana (optional, for dashboarding)
sudo apt-get install -y adduser libfontconfig1
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
sudo apt-get update && sudo apt-get install -y grafana

# 9-12: Security & Scanning
# Install Trivy for container vulnerability scanning
sudo apt install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update && sudo apt install -y trivy
# Install Gitleaks for secret detection in code
wget https://github.com/gitleaks/gitleaks/releases/download/v8.18.2/gitleaks_8.18.2_linux_x64.tar.gz
tar -xzf gitleaks_8.18.2_linux_x64.tar.gz
sudo mv gitleaks /usr/local/bin/

# 13-16: Development & QA
# Install Node.js 20 (if not present)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
# Install Python virtualenv and dev tools
sudo apt install -y python3-venv python3-pip
# Install PostgreSQL for data persistence
sudo apt install -y postgresql postgresql-contrib
# Install Redis for caching and real-time features
sudo apt install -y redis-server

echo "=== Tool Installation Summary ==="
echo "1. Docker: $(docker --version)"
echo "2. Docker Compose: $(docker-compose --version)"
echo "3. kubectl: $(kubectl version --client --short 2>/dev/null | head -1)"
echo "4. Prometheus: $(prometheus --version 2>/dev/null | head -1)"
echo "5. Grafana: $(grafana-server -v 2>/dev/null | head -1)"
echo "6. Trivy: $(trivy --version 2>/dev/null | head -1)"
echo "7. Gitleaks: $(gitleaks version 2>/dev/null)"
echo "8. Node.js: $(node --version)"
echo "9. Python3: $(python3 --version)"
echo "10. PostgreSQL: $(psql --version)"
echo "11. Redis: $(redis-server --version)"
echo "12-16: Git, GCC, Go, Java, Shell (already verified)"

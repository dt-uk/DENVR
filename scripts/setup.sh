#!/bin/bash

# Project SLK6 Setup Script
# For Ubuntu/Linux (Lenovo ThinkPad), macOS, and Windows WSL

set -e

echo "=== Project SLK6 Setup ==="
echo "System: $(uname -s)"
echo "Architecture: $(uname -m)"

# Check dependencies
check_dependency() {
    if command -v $1 &> /dev/null; then
        echo "✓ $1 installed"
        return 0
    else
        echo "✗ $1 not found"
        return 1
    fi
}

echo "Checking dependencies..."
deps=("git" "python3" "node" "npm" "java" "go" "g++" "make")
missing_deps=0

for dep in "${deps[@]}"; do
    if ! check_dependency $dep; then
        missing_deps=$((missing_deps + 1))
    fi
done

if [ $missing_deps -gt 0 ]; then
    echo "Installing missing dependencies..."
    
    if [[ "$(uname)" == "Linux" ]]; then
        sudo apt-get update
        sudo apt-get install -y python3 python3-pip nodejs npm default-jdk golang g++ make
        
    elif [[ "$(uname)" == "Darwin" ]]; then
        if ! command -v brew &> /dev/null; then
            echo "Please install Homebrew first: https://brew.sh"
            exit 1
        fi
        brew install python node openjdk go gcc make
        
    else
        echo "Please install dependencies manually for your OS."
    fi
fi

# Python packages
echo "Installing Python packages..."
pip3 install --user numpy sympy matplotlib pytest

# Node packages
echo "Installing Node packages..."
npm install -g typescript jest react-scripts vite

# Create environment file
cat > .env << 'ENV'
PROJECT_NAME=SLK6-Noetherian-Modules
AUTHOR=shellworlds
VERSION=1.0.0
PLATFORM=$(uname -s)
ENV

echo "Setup complete!"
echo "Run 'python3 src/python/noetherian_module.py' to test."

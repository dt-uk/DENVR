#!/bin/bash

# Nullstellensatz Project Installation Script
# Cross-platform installation for Ubuntu, Mac, and Windows (WSL)

set -e

echo "==============================================="
echo "Nullstellensatz Project Installation"
echo "==============================================="
echo ""

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     OS_NAME="Linux" ;;
    Darwin*)    OS_NAME="Mac" ;;
    CYGWIN*)    OS_NAME="Windows" ;;
    MINGW*)     OS_NAME="Windows" ;;
    *)          OS_NAME="Unknown" ;;
esac

echo "Detected OS: $OS_NAME"
echo ""

# Function to check command existence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install package based on OS
install_package() {
    local pkg=$1
    echo "Installing $pkg..."
    
    case "$OS_NAME" in
        Linux)
            if command_exists apt; then
                sudo apt update && sudo apt install -y $pkg
            elif command_exists yum; then
                sudo yum install -y $pkg
            elif command_exists dnf; then
                sudo dnf install -y $pkg
            fi
            ;;
        Mac)
            if command_exists brew; then
                brew install $pkg
            else
                echo "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            ;;
        Windows)
            echo "Please install $pkg manually on Windows"
            ;;
    esac
}

# Check and install Python
if ! command_exists python3; then
    echo "Python3 not found. Installing..."
    install_package python3 python3-pip python3-venv
fi

# Check and install Node.js
if ! command_exists node; then
    echo "Node.js not found. Installing..."
    case "$OS_NAME" in
        Linux)
            curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
            sudo apt install -y nodejs
            ;;
        Mac)
            brew install node
            ;;
        Windows)
            echo "Please install Node.js from https://nodejs.org/"
            ;;
    esac
fi

# Check and install Java
if ! command_exists javac; then
    echo "Java JDK not found. Installing..."
    case "$OS_NAME" in
        Linux)
            sudo apt install -y default-jdk
            ;;
        Mac)
            brew install openjdk
            ;;
        Windows)
            echo "Please install Java JDK from https://adoptium.net/"
            ;;
    esac
fi

# Check and install C++ compiler
if ! command_exists g++; then
    echo "C++ compiler not found. Installing..."
    case "$OS_NAME" in
        Linux)
            sudo apt install -y g++ cmake build-essential
            ;;
        Mac)
            brew install gcc cmake
            ;;
        Windows)
            echo "Please install MinGW from https://www.mingw-w64.org/"
            ;;
    esac
fi

# Check and install Go (optional)
if ! command_exists go; then
    echo "Go not found. Installing (optional)..."
    case "$OS_NAME" in
        Linux)
            sudo apt install -y golang-go || echo "Go installation skipped"
            ;;
        Mac)
            brew install go || echo "Go installation skipped"
            ;;
        Windows)
            echo "Please install Go from https://go.dev/dl/"
            ;;
    esac
fi

# Setup project
echo ""
echo "Setting up project dependencies..."
make setup

echo ""
echo "==============================================="
echo "Installation Complete!"
echo "==============================================="
echo ""
echo "Quick Start Commands:"
echo "---------------------"
echo "1. Setup project:          make setup"
echo "2. Test all implementations: make test"
echo "3. Run Python solver:      make run-python"
echo "4. Run Node.js API:        make run-node"
echo "5. Run React frontend:     make run-react"
echo "6. Run C++ solver:         make run-cpp"
echo "7. Run Java solver:        make run-java"
echo "8. Push to all repos:      make push-all"
echo ""
echo "For help:                  make help"
echo ""

#!/bin/bash

# System Check Script for Nullstellensatz Project
# Verifies all dependencies and system requirements

echo "==============================================="
echo "Nullstellensatz Project - System Check"
echo "==============================================="
echo ""

# System Information
echo "1. SYSTEM INFORMATION:"
echo "----------------------"
echo "Hostname: $(hostname)"
echo "OS: $(uname -s) $(uname -r)"
echo "Architecture: $(uname -m)"
echo ""

# Memory and Storage
echo "2. RESOURCES:"
echo "-------------"
echo "Memory:"
free -h | head -2
echo ""
echo "Storage:"
df -h / | tail -1
echo ""

# Dependencies Check
echo "3. DEPENDENCIES CHECK:"
echo "----------------------"

check_dependency() {
    local cmd=$1
    local name=$2
    local required=$3
    
    if command -v $cmd >/dev/null 2>&1; then
        version=$($cmd --version 2>/dev/null | head -1)
        echo "✓ $name: $version"
        return 0
    else
        if [ "$required" = "required" ]; then
            echo "✗ $name: NOT FOUND (REQUIRED)"
            return 1
        else
            echo "○ $name: NOT FOUND (optional)"
            return 0
        fi
    fi
}

# Required dependencies
check_dependency python3 "Python 3" required
check_dependency pip3 "Python pip" required
check_dependency node "Node.js" required
check_dependency npm "NPM" required
check_dependency javac "Java Compiler" required
check_dependency java "Java Runtime" required
check_dependency g++ "C++ Compiler" required
echo ""

# Optional dependencies
echo "4. OPTIONAL DEPENDENCIES:"
echo "-------------------------"
check_dependency go "Go" optional
check_dependency docker "Docker" optional
check_dependency docker-compose "Docker Compose" optional
echo ""

# Python packages check
echo "5. PYTHON PACKAGES:"
echo "-------------------"
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
    echo "Virtual environment: Active"
    
    # Check key packages
    for pkg in sympy numpy scipy; do
        if python3 -c "import $pkg" 2>/dev/null; then
            version=$(python3 -c "import $pkg; print(f'  ✓ $pkg:', $pkg.__version__)")
            echo "$version"
        else
            echo "  ✗ $pkg: Not installed"
        fi
    done
else
    echo "Virtual environment: Not found (run 'make setup')"
fi
deactivate 2>/dev/null || true
echo ""

# Node packages check
echo "6. NODE.JS PACKAGES:"
echo "--------------------"
if [ -d "node/node_modules" ]; then
    echo "Node modules: Installed"
else
    echo "Node modules: Not found (run 'make setup')"
fi
echo ""

# Git configuration
echo "7. GIT CONFIGURATION:"
echo "---------------------"
git config --get user.name >/dev/null 2>&1 && echo "✓ Username: $(git config --get user.name)" || echo "✗ Git username not set"
git config --get user.email >/dev/null 2>&1 && echo "✓ Email: $(git config --get user.email)" || echo "✗ Git email not set"

# Check SSH access to GitHub
echo ""
echo "8. GITHUB SSH ACCESS:"
echo "---------------------"
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "✓ SSH authentication: Successful"
else
    echo "✗ SSH authentication: Failed"
fi
echo ""

# Project structure
echo "9. PROJECT STRUCTURE:"
echo "---------------------"
if [ -d "python/src" ] && [ -d "node/src" ] && [ -d "react/src" ]; then
    echo "✓ Project structure: Complete"
    echo "  Found implementations:"
    [ -f "python/src/nullstellensatz.py" ] && echo "    - Python"
    [ -f "node/src/server.js" ] && echo "    - Node.js"
    [ -f "react/src/components/NullstellensatzSolver.jsx" ] && echo "    - React"
    [ -f "cpp/src/nullstellensatz.cpp" ] && echo "    - C++"
    [ -f "java/src/main/java/com/nullstellensatz/Main.java" ] && echo "    - Java"
else
    echo "✗ Project structure: Incomplete"
fi
echo ""

echo "==============================================="
echo "SYSTEM CHECK COMPLETE"
echo "==============================================="
echo ""
echo "Next Steps:"
echo "1. Run 'make setup' to install dependencies"
echo "2. Run 'make test' to verify all implementations"
echo "3. Run 'make push-all' to deploy to repositories"
echo ""

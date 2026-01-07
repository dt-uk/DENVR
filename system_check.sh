#!/bin/bash
echo "ENVR17 System Check"
echo "OS: $(grep PRETTY_NAME /etc/os-release 2>/dev/null || echo "Unknown")"
echo "Docker: $(docker --version 2>/dev/null || echo "Not installed")"
echo "Git: $(git --version)"
echo "Python3: $(python3 --version 2>/dev/null || echo "Not installed")"
echo "Node.js: $(node --version 2>/dev/null || echo "Not installed")"

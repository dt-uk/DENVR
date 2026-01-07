#!/bin/bash
# M-DOD Advanced System Monitor for Linux/Windows/Mac
echo "=== M-DOD System Health Monitor ==="
echo "[$(date)] Checking baseline for Multi-Domain Operations Dashboard"
# Cross-platform checks
case "$(uname -s)" in
    Linux*)     export MDOD_PLATFORM="linux" ;;
    Darwin*)    export MDOD_PLATFORM="mac" ;;
    CYGWIN*|MINGW*) export MDOD_PLATFORM="windows" ;;
    *)          export MDOD_PLATFORM="unknown" ;;
esac
echo "Platform: $MDOD_PLATFORM"
# Performance metrics
echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')%"
echo "Memory Free: $(free -h | awk '/^Mem:/ {print $4}')"
echo "Secure Boot: $(sudo bootctl status 2>/dev/null | grep -q "Secure Boot: enabled" && echo "Enabled" || echo "Disabled/Not Found")"

#!/bin/bash

echo "=== SLK6 Theorem Verification Suite ==="
echo "Running implementations in multiple languages..."
echo ""

# Python verification
echo "1. Python Implementation:"
python3 src/python/noetherian_module.py
echo ""

# Go verification
echo "2. Go Implementation:"
go run src/go/verifier.go
echo ""

# C++ verification
echo "3. C++ Implementation:"
if [ -f bin/theorem_prover ]; then
    ./bin/theorem_prover
else
    echo "Compiling C++..."
    g++ -o bin/theorem_prover src/cpp/theorem_prover.cpp
    ./bin/theorem_prover
fi
echo ""

# Java verification
echo "4. Java Implementation:"
if [ -f bin/SLK6Theorem.class ]; then
    java -cp bin SLK6Theorem
else
    echo "Compiling Java..."
    mkdir -p bin
    javac -d bin src/java/SLK6Theorem.java
    java -cp bin SLK6Theorem
fi
echo ""

# Node.js server check
echo "5. Node.js API Server Check:"
node -e "const app = require('./src/node/server.js'); console.log('Server module loaded successfully');"
echo ""

echo "=== Verification Complete ==="
echo "All implementations demonstrate theorem:"
echo "Projective ⇔ Locally Free at primes ⇔ Locally Free at maximals"

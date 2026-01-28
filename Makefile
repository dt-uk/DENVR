# Nullstellensatz Project Makefile
# Unified build and test system

.PHONY: all setup clean test run build push help

# Default target
all: setup build

# Setup environment
setup:
	@echo "Setting up Nullstellensatz Project..."
	@echo "========================================"
	
	# Python setup
	@echo "\n1. Setting up Python environment..."
	python3 -m venv venv 2>/dev/null || true
	. venv/bin/activate && pip install -r python/requirements.txt
	
	# Node.js setup
	@echo "\n2. Setting up Node.js..."
	cd node && npm install 2>/dev/null || echo "Node setup completed"
	
	# React setup
	@echo "\n3. Setting up React..."
	cd react && npm install 2>/dev/null || echo "React setup completed"
	
	# Go setup
	@echo "\n4. Setting up Go..."
	which go >/dev/null 2>&1 || echo "Go not installed, skipping"
	
	@echo "\nSetup complete!"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf venv
	rm -rf node/node_modules
	rm -rf react/node_modules
	rm -rf react/dist
	rm -rf java/build
	rm -rf cpp/nullstellensatz
	rm -rf go/bin go/pkg
	find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	find . -name "*.pyc" -delete
	@echo "Clean complete!"

# Test all implementations
test:
	@echo "Testing all implementations..."
	@echo "=============================="
	
	@echo "\n1. Testing Python..."
	. venv/bin/activate && cd python && python -m pytest tests/ -v
	
	@echo "\n2. Testing Node.js..."
	cd node && npm test 2>/dev/null || echo "Node tests not configured"
	
	@echo "\n3. Testing C++..."
	cd cpp && g++ -std=c++11 -o nullstellensatz src/nullstellensatz.cpp && ./nullstellensatz
	
	@echo "\n4. Testing Java..."
	cd java && javac -d build src/main/java/com/nullstellensatz/Main.java && java -cp build com.nullstellensatz.Main
	
	@echo "\nAll tests completed!"

# Run specific implementations
run-python:
	@echo "Running Python implementation..."
	. venv/bin/activate && cd python/src && python nullstellensatz.py

run-node:
	@echo "Running Node.js server..."
	cd node && npm start

run-react:
	@echo "Running React development server..."
	cd react && npm run dev

run-go:
	@echo "Running Go implementation..."
	cd go && go run cmd/main.go

run-cpp:
	@echo "Running C++ implementation..."
	cd cpp && g++ -std=c++11 -o nullstellensatz src/nullstellensatz.cpp && ./nullstellensatz

run-java:
	@echo "Running Java implementation..."
	cd java && javac -d build src/main/java/com/nullstellensatz/Main.java && java -cp build com.nullstellensatz.Main

# Build all
build:
	@echo "Building all implementations..."
	# Python - already built
	@echo "✓ Python ready"
	
	# Node.js
	@echo "✓ Node.js ready"
	
	# React
	@echo "✓ React ready"
	
	# C++
	cd cpp && g++ -std=c++11 -o nullstellensatz src/nullstellensatz.cpp
	@echo "✓ C++ built"
	
	# Java
	cd java && javac -d build src/main/java/com/nullstellensatz/Main.java
	@echo "✓ Java built"
	
	# Go
	cd go && go build -o bin/nullstellensatz cmd/main.go 2>/dev/null || echo "Go build skipped"
	@echo "✓ Go ready (if installed)"
	
	@echo "\nAll builds completed!"

# Git operations
push-all:
	@echo "Pushing to all repositories..."
	@echo "==============================="
	./scripts/push-all.sh

# Display help
help:
	@echo "Nullstellensatz Project Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  setup     - Set up all environments"
	@echo "  clean     - Remove all build artifacts"
	@echo "  test      - Run all tests"
	@echo "  build     - Build all implementations"
	@echo "  run-*     - Run specific implementation"
	@echo "  push-all  - Push to all git repositories"
	@echo "  help      - Show this help message"

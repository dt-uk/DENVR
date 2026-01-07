#!/bin/bash
# M-DOD One-Command Deployment for Linux/Mac/Windows (via Docker)
set -e

echo "Initializing M-DOD Deployment..."
export COMPOSE_PROJECT_NAME="mdod"

# Platform-specific adjustments
case "$(uname -s)" in
    Linux*)     DOCKER_COMPOSE="docker-compose" ;;
    Darwin*)    DOCKER_COMPOSE="docker-compose" ;;
    CYGWIN*|MINGW*) DOCKER_COMPOSE="docker-compose.exe" ;;
    *)          echo "Unsupported OS"; exit 1 ;;
esac

# Build and deploy
$DOCKER_COMPOSE -f docker/mdod-compose.yml build
$DOCKER_COMPOSE -f docker/mdod-compose.yml up -d

echo "Deployment complete. Services:"
echo "- Dashboard: http://localhost:8080"
echo "- API Gateway: http://localhost:3000"
echo "- AI Fusion: http://localhost:8000/docs"

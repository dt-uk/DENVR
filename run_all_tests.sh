#!/bin/bash
echo "Running all containerized tests"
docker-compose -f docker-compose.test.yml up -d
sleep 5
python3 test_runner.py

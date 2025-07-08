#!/bin/bash

echo "🐳 Docker Installation Check"
echo "=========================="

# Test 1: Check if Docker is installed
echo -n "Docker installed: "
if command -v docker >/dev/null 2>&1; then
    echo "✅ YES"
    docker --version
else
    echo "❌ NO"
    exit 1
fi

echo ""

# Test 2: Check if Docker Compose is available
echo -n "Docker Compose available: "
if command -v docker-compose >/dev/null 2>&1; then
    echo "✅ YES (standalone)"
    docker-compose --version
elif docker compose version >/dev/null 2>&1; then
    echo "✅ YES (plugin)"
    docker compose version
else
    echo "❌ NO"
fi

echo ""

# Test 3: Check Docker daemon
echo -n "Docker daemon running: "
if docker info >/dev/null 2>&1; then
    echo "✅ YES"
else
    echo "❌ NO"
    echo "Try: sudo systemctl start docker"
    echo "Or: sudo dockerd &"
fi

echo ""

# Test 4: Check user permissions
echo -n "User in docker group: "
if groups | grep -q docker; then
    echo "✅ YES"
else
    echo "❌ NO"
    echo "Run: sudo usermod -aG docker \$USER"
    echo "Then: newgrp docker"
fi

echo ""

# Test 5: Test Docker functionality
echo -n "Docker functional test: "
if docker run --rm hello-world >/dev/null 2>&1; then
    echo "✅ PASSED"
    echo ""
    echo "🎉 Docker is ready!"
    echo ""
    echo "Next: Run './setup.sh' to start Glinta Hotspot"
else
    echo "❌ FAILED"
    echo "Check the above issues and try again"
fi
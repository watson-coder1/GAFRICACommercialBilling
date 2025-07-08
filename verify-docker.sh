#!/bin/bash

echo "=== Docker Installation Verification ==="
echo ""

# Check Docker version
echo "1. Checking Docker version..."
if command -v docker >/dev/null 2>&1; then
    docker --version
    echo "✓ Docker is installed"
else
    echo "✗ Docker is not installed"
    exit 1
fi

echo ""

# Check Docker Compose version
echo "2. Checking Docker Compose version..."
if command -v docker-compose >/dev/null 2>&1; then
    docker-compose --version
    echo "✓ Docker Compose is installed"
elif docker compose version >/dev/null 2>&1; then
    docker compose version
    echo "✓ Docker Compose plugin is installed"
else
    echo "✗ Docker Compose is not installed"
    exit 1
fi

echo ""

# Check Docker service status
echo "3. Checking Docker service..."
if docker info >/dev/null 2>&1; then
    echo "✓ Docker service is running"
else
    echo "✗ Docker service is not running"
    echo "Try: sudo systemctl start docker"
    exit 1
fi

echo ""

# Test Docker with hello-world
echo "4. Testing Docker with hello-world container..."
if docker run --rm hello-world >/dev/null 2>&1; then
    echo "✓ Docker is working correctly"
else
    echo "✗ Docker test failed"
    echo "You may need to add your user to the docker group:"
    echo "sudo usermod -aG docker \$USER"
    echo "Then log out and log back in"
    exit 1
fi

echo ""
echo "🎉 Docker installation successful!"
echo ""
echo "Next steps:"
echo "1. Run: cd '/mnt/d/Glinta Hotspot/Glinta-Hotspot-Billing-System'"
echo "2. Run: ./setup.sh"
echo "3. Choose option 1 for Docker setup"
echo ""
echo "Or run directly:"
echo "docker-compose up -d"
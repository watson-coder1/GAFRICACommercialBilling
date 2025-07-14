#!/bin/bash

echo "=== SSL Certificate Cleanup and Setup ==="

# Step 1: Remove self-signed certificates
echo "1. Removing self-signed certificates..."
docker exec glinta-web rm -f /etc/ssl/private/apache-selfsigned.key
docker exec glinta-web rm -f /etc/ssl/certs/apache-selfsigned.crt

# Step 2: Install certbot if not already installed
echo "2. Installing certbot..."
docker exec glinta-web apt update
docker exec glinta-web apt install certbot python3-certbot-apache -y

# Step 3: Disable self-signed SSL site
echo "3. Disabling self-signed SSL site..."
docker exec glinta-web a2dissite default-ssl

# Step 4: Test Apache configuration
echo "4. Testing Apache configuration..."
docker exec glinta-web apache2ctl configtest

echo "=== Ready for Let's Encrypt ==="
echo "Now run: docker exec -it glinta-web certbot --apache -d glintaafrica.com"
echo "After certbot succeeds, restart: docker restart glinta-web"
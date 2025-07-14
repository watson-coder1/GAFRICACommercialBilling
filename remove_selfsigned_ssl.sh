#!/bin/bash

echo "=== Removing Self-Signed SSL Certificates on DigitalOcean ==="

# Step 1: SSH into your DigitalOcean server
echo "SSH into your server first:"
echo "ssh root@165.227.173.29"
echo ""

# Step 2: Find your running container
echo "Find your container:"
echo "docker ps"
echo ""

# Step 3: Remove self-signed certificates from container
echo "Remove self-signed certificates:"
echo "docker exec CONTAINER_NAME rm -f /etc/ssl/private/apache-selfsigned.key"
echo "docker exec CONTAINER_NAME rm -f /etc/ssl/certs/apache-selfsigned.crt"
echo ""

# Step 4: Remove self-signed SSL site config
echo "Disable self-signed SSL site:"
echo "docker exec CONTAINER_NAME a2dissite default-ssl"
echo ""

# Step 5: Remove any custom SSL configs you created
echo "Remove custom SSL configs (if any):"
echo "docker exec CONTAINER_NAME rm -f /etc/apache2/sites-available/default-ssl.conf"
echo ""

# Step 6: Restart Apache
echo "Restart Apache:"
echo "docker exec CONTAINER_NAME systemctl reload apache2"
echo ""

echo "=== Alternative: If not using Docker ==="
echo "If running directly on the server (not in Docker):"
echo "sudo rm -f /etc/ssl/private/apache-selfsigned.key"
echo "sudo rm -f /etc/ssl/certs/apache-selfsigned.crt"
echo "sudo a2dissite default-ssl"
echo "sudo systemctl reload apache2"
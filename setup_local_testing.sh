#!/bin/bash

echo "=== Glinta Hotspot Billing System - Local Testing Setup ==="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}1. Setting up local testing environment...${NC}"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not running. Please start Docker and try again.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Docker is running${NC}"

# Stop any existing containers
echo -e "${YELLOW}2. Stopping existing containers...${NC}"
docker-compose -f docker-compose.local.yml down

# Build and start local containers
echo -e "${YELLOW}3. Building and starting local containers...${NC}"
docker-compose -f docker-compose.local.yml up -d --build

# Wait for MySQL to be ready
echo -e "${YELLOW}4. Waiting for MySQL to be ready...${NC}"
echo "This may take a few seconds..."

# Function to check if MySQL is ready
check_mysql() {
    docker exec mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! -e "SELECT 1" > /dev/null 2>&1
}

# Wait for MySQL to be ready (max 60 seconds)
counter=0
while ! check_mysql && [ $counter -lt 60 ]; do
    echo -n "."
    sleep 1
    counter=$((counter + 1))
done

if check_mysql; then
    echo -e "\n${GREEN}✅ MySQL is ready!${NC}"
else
    echo -e "\n${RED}❌ MySQL failed to start properly${NC}"
    exit 1
fi

# Import database schema
echo -e "${YELLOW}5. Importing database schema...${NC}"
docker exec -i mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! nuxbill_local < install/phpnuxbill.sql

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Database schema imported successfully${NC}"
else
    echo -e "${RED}❌ Failed to import database schema${NC}"
    exit 1
fi

# Apply security indexes
echo -e "${YELLOW}6. Applying security performance indexes...${NC}"
docker exec -i mysql-local mysql -u nuxbill -pSecureP@ssw0rd123! nuxbill_local < security_performance_indexes.sql

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Security indexes applied successfully${NC}"
else
    echo -e "${YELLOW}⚠️  Some indexes may have failed (this is normal if tables don't exist yet)${NC}"
fi

# Run security verification
echo -e "${YELLOW}7. Running security verification...${NC}"
php verify_security_fixes.php

echo ""
echo -e "${GREEN}=== Local Testing Environment Ready! ===${NC}"
echo ""
echo -e "${YELLOW}Access your local application at:${NC}"
echo -e "${GREEN}🌐 http://localhost:8080${NC}"
echo ""
echo -e "${YELLOW}Database connection details:${NC}"
echo "Host: localhost"
echo "Port: 3308"
echo "Database: nuxbill_local"
echo "Username: nuxbill"
echo "Password: SecureP@ssw0rd123!"
echo ""
echo -e "${YELLOW}To stop the local environment:${NC}"
echo -e "${GREEN}docker-compose -f docker-compose.local.yml down${NC}"
echo ""
echo -e "${YELLOW}To view logs:${NC}"
echo -e "${GREEN}docker-compose -f docker-compose.local.yml logs -f${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Test the application functionality"
echo "2. Try login/registration"
echo "3. Test admin features"
echo "4. Verify security fixes are working"
echo "5. Check for any errors in the logs"
echo ""
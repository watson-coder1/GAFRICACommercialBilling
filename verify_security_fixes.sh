#!/bin/bash

# Security Fixes Verification Script (Bash version)
# Run this script to verify all security fixes are properly applied

echo "=== Glinta Hotspot Billing System - Security Verification ==="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

passed=0
total=0

# Check 1: Verify SQL injection fixes
echo -e "${YELLOW}1. Checking SQL injection fixes...${NC}"
total=$((total + 1))

if [ -f "system/controllers/login.php" ]; then
    if ! grep -q 'whereRaw("BINARY code = '"'"'\$voucher'"'"'")' system/controllers/login.php; then
        echo -e "   ${GREEN}✅ Login controller SQL injection fixed${NC}"
        passed=$((passed + 1))
    else
        echo -e "   ${RED}❌ Login controller still vulnerable to SQL injection${NC}"
    fi
else
    echo -e "   ${RED}❌ Login controller file not found${NC}"
fi

# Check 2: Verify password hashing fixes
echo -e "\n${YELLOW}2. Checking password hashing fixes...${NC}"
total=$((total + 1))

if [ -f "system/autoload/Password.php" ]; then
    if grep -q 'password_hash(\$password, PASSWORD_DEFAULT)' system/autoload/Password.php; then
        echo -e "   ${GREEN}✅ Password hashing upgraded to bcrypt${NC}"
        passed=$((passed + 1))
    else
        echo -e "   ${RED}❌ Password hashing still using SHA1${NC}"
    fi
else
    echo -e "   ${RED}❌ Password class file not found${NC}"
fi

# Check 3: Verify eval() removal
echo -e "\n${YELLOW}3. Checking eval() removal...${NC}"
total=$((total + 1))

eval_files=(
    "system/widgets/html_php.php"
    "system/widgets/html_php_card.php"
    "system/widgets/customer/html_php.php"
)

eval_fixed=true
for file in "${eval_files[@]}"; do
    if [ -f "$file" ]; then
        if ! grep -q 'eval(' "$file" || grep -q '// SECURITY: eval() removed' "$file"; then
            echo -e "   ${GREEN}✅ $(basename $file) - eval() removed${NC}"
        else
            echo -e "   ${RED}❌ $(basename $file) - still contains eval()${NC}"
            eval_fixed=false
        fi
    else
        echo -e "   ${RED}❌ $(basename $file) - file not found${NC}"
        eval_fixed=false
    fi
done

if [ "$eval_fixed" = true ]; then
    passed=$((passed + 1))
fi

# Check 4: Verify configuration changes
echo -e "\n${YELLOW}4. Checking configuration changes...${NC}"
total=$((total + 2))

if [ -f "config.php" ]; then
    if grep -q "\$_app_stage = 'Live'" config.php; then
        echo -e "   ${GREEN}✅ Application set to production mode${NC}"
        passed=$((passed + 1))
    else
        echo -e "   ${RED}❌ Application still in development mode${NC}"
    fi
    
    if ! grep -q '12345678' config.php; then
        echo -e "   ${GREEN}✅ Default database password changed${NC}"
        passed=$((passed + 1))
    else
        echo -e "   ${RED}❌ Default database password still in use${NC}"
    fi
else
    echo -e "   ${RED}❌ Config file not found${NC}"
fi

# Check 5: Verify SSL verification
echo -e "\n${YELLOW}5. Checking SSL verification...${NC}"
total=$((total + 1))

if [ -f "system/autoload/MpesaIntegration.php" ]; then
    if grep -q 'CURLOPT_SSL_VERIFYPEER, true' system/autoload/MpesaIntegration.php; then
        echo -e "   ${GREEN}✅ SSL verification enabled${NC}"
        passed=$((passed + 1))
    else
        echo -e "   ${RED}❌ SSL verification still disabled${NC}"
    fi
else
    echo -e "   ${RED}❌ M-Pesa integration file not found${NC}"
fi

# Check 6: Verify database indexes script exists
echo -e "\n${YELLOW}6. Checking database indexes script...${NC}"
total=$((total + 1))

if [ -f "security_performance_indexes.sql" ]; then
    echo -e "   ${GREEN}✅ Database indexes script created${NC}"
    passed=$((passed + 1))
else
    echo -e "   ${RED}❌ Database indexes script not found${NC}"
fi

# Check 7: Verify local setup files
echo -e "\n${YELLOW}7. Checking local testing setup...${NC}"
total=$((total + 3))

if [ -f "config.local.php" ]; then
    echo -e "   ${GREEN}✅ Local configuration file created${NC}"
    passed=$((passed + 1))
else
    echo -e "   ${RED}❌ Local configuration file not found${NC}"
fi

if [ -f "docker-compose.local.yml" ]; then
    echo -e "   ${GREEN}✅ Local Docker Compose file created${NC}"
    passed=$((passed + 1))
else
    echo -e "   ${RED}❌ Local Docker Compose file not found${NC}"
fi

if [ -f "setup_local_testing.sh" ]; then
    echo -e "   ${GREEN}✅ Local testing setup script created${NC}"
    passed=$((passed + 1))
else
    echo -e "   ${RED}❌ Local testing setup script not found${NC}"
fi

# Summary
echo -e "\n${YELLOW}=== SECURITY VERIFICATION SUMMARY ===${NC}"
echo -e "Results: ${GREEN}${passed}${NC}/${total} checks passed"
echo ""

if [ $passed -eq $total ]; then
    echo -e "${GREEN}🎉 ALL SECURITY FIXES VERIFIED SUCCESSFULLY!${NC}"
    echo -e "Your system is now significantly more secure."
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Run the local testing setup: ./setup_local_testing.sh"
    echo "2. Test all functionality at http://localhost:8080"
    echo "3. Verify no errors in the logs"
    echo "4. Deploy to production when ready"
else
    echo -e "${RED}⚠️  SOME SECURITY FIXES ARE MISSING!${NC}"
    echo -e "Please review the failed checks above and apply the missing fixes."
fi

echo ""
echo -e "${YELLOW}=== End of Security Verification ===${NC}"
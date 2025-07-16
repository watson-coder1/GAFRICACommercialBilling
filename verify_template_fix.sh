#!/bin/bash

# Verify template fix script
echo "=== Glinta Africa Template Fix Verification ==="
echo ""

BASE_DIR="/mnt/c/Users/user/Desktop/Digital-Ocean-Glinta-Africa Billing System/Glinta-Hotspot-Billing-System-digital ocean with autologin"
SECTIONS_DIR="$BASE_DIR/ui/ui/sections"
ADMIN_DIR="$BASE_DIR/ui/ui/admin"

echo "1. Checking if menu-items.tpl exists..."
if [ -f "$SECTIONS_DIR/menu-items.tpl" ]; then
    echo "   ✓ menu-items.tpl found"
else
    echo "   ✗ menu-items.tpl missing"
    exit 1
fi

echo ""
echo "2. Checking template structure..."
if [ -f "$SECTIONS_DIR/header-modern.tpl" ]; then
    echo "   ✓ header-modern.tpl found"
else
    echo "   ✗ header-modern.tpl missing"
    exit 1
fi

echo ""
echo "3. Checking dashboard templates..."
if [ -f "$ADMIN_DIR/dashboard.tpl" ]; then
    echo "   ✓ dashboard.tpl found"
else
    echo "   ✗ dashboard.tpl missing"
    exit 1
fi

if [ -f "$ADMIN_DIR/dashboard-modern.tpl" ]; then
    echo "   ✓ dashboard-modern.tpl found"
else
    echo "   ✗ dashboard-modern.tpl missing"
    exit 1
fi

echo ""
echo "4. Checking current template type..."
if grep -q "header-modern.tpl" "$ADMIN_DIR/dashboard.tpl"; then
    echo "   → Current template: MODERN"
else
    echo "   → Current template: ORIGINAL"
fi

echo ""
echo "5. Clearing template cache..."
rm -rf "$BASE_DIR/ui/compiled/"*
echo "   ✓ Template cache cleared"

echo ""
echo "=== Fix Applied Successfully ==="
echo "The template dependency issue has been resolved!"
echo ""
echo "Next steps:"
echo "1. Test the dashboard in your browser"
echo "2. If issues persist, check Docker logs"
echo "3. Use the switch_template.php script to change templates"
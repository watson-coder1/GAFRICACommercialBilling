# Smarty Template Error Fix Guide

## Issue Analysis

### Root Cause
The error "Unable to load template 'file:sections/menu-items.tpl' in 'file:sections/header-modern.tpl'" occurred because:

1. **Missing Dependency**: The modern template (`header-modern.tpl`) was trying to include a menu template (`sections/menu-items.tpl`) that didn't exist
2. **Template Structure Mismatch**: The modern template used a modular approach while the original template had inline menu structure
3. **Broken Template Chain**: When `dashboard-modern.tpl` was copied to `dashboard.tpl`, it created a dependency on the modern header template

### Technical Details
- **Template Engine**: Smarty 3.x
- **Cache Location**: `ui/compiled/`
- **Error Location**: Line 423 in `ui/ui/sections/header-modern.tpl`
- **Missing File**: `ui/ui/sections/menu-items.tpl`

## Solution Implemented

### 1. Created Missing Template File
**File**: `/ui/ui/sections/menu-items.tpl`
- Contains complete menu structure extracted from original header
- Includes all menu items: Services, Maps, Reports, Messages, Network, Settings, etc.
- Maintains proper Smarty syntax and conditional logic
- Supports all user roles (SuperAdmin, Admin, Agent, Report)

### 2. Template Management System
**File**: `/switch_template.php`
- Safely switch between original and modern templates
- Automatic dependency checking
- Template cache clearing
- Status verification

### 3. Verification Script
**File**: `/verify_template_fix.sh`
- Checks all template dependencies
- Verifies file existence
- Clears template cache
- Provides fix status

## Usage Instructions

### Option 1: Keep Original Template (Recommended)
```bash
# Current setup uses original template - no changes needed
# System should work normally now
```

### Option 2: Switch to Modern Template
```bash
# Using PHP (if available)
php switch_template.php modern

# Or manually copy files
cp ui/ui/admin/dashboard-modern.tpl ui/ui/admin/dashboard.tpl
```

### Option 3: Switch Back to Original
```bash
# Using PHP (if available)
php switch_template.php original

# Or manually copy files
cp ui/ui/admin/dashboard-backup.tpl ui/ui/admin/dashboard.tpl
```

## File Structure

```
ui/ui/
├── admin/
│   ├── dashboard.tpl           # Active dashboard template
│   ├── dashboard-modern.tpl    # Modern dashboard template
│   ├── dashboard-backup.tpl    # Original dashboard backup
│   └── header.tpl              # Original header
├── sections/
│   ├── header.tpl              # Points to admin/header.tpl
│   ├── header-modern.tpl       # Modern header template
│   ├── menu-items.tpl          # ✓ CREATED - Menu structure
│   └── footer.tpl              # Footer template
└── compiled/                   # Template cache (cleared)
```

## Prevention Strategies

### 1. Template Dependency Mapping
- **Always check includes**: Before creating/modifying templates, verify all included files exist
- **Use relative paths**: Ensure template paths are correct relative to the template directory
- **Test both environments**: Verify templates work in both development and production

### 2. Version Control Best Practices
```bash
# Create feature branch for template changes
git checkout -b feature/modern-ui

# Test thoroughly before merging
# Keep original templates as backup
```

### 3. Template Validation Script
```bash
# Run before deploying template changes
./verify_template_fix.sh
```

### 4. Cache Management
```bash
# Clear template cache after changes
rm -rf ui/compiled/*
```

## Template Structure Recommendations

### 1. Modular Design
```
sections/
├── header.tpl           # Main header
├── header-modern.tpl    # Modern header variant
├── menu-items.tpl       # Reusable menu structure
├── sidebar.tpl          # Sidebar component
└── footer.tpl          # Footer component
```

### 2. Conditional Loading
```smarty
{* Example conditional template loading *}
{if $template_mode == 'modern'}
    {include file="sections/header-modern.tpl"}
{else}
    {include file="sections/header.tpl"}
{/if}
```

### 3. Template Inheritance
```smarty
{* Base template structure *}
{extends file="layouts/base.tpl"}

{block name="content"}
    {* Page-specific content *}
{/block}
```

## Troubleshooting

### Error: "Unable to load template"
1. Check file exists: `ls -la ui/ui/sections/menu-items.tpl`
2. Verify permissions: `chmod 644 ui/ui/sections/menu-items.tpl`
3. Clear cache: `rm -rf ui/compiled/*`
4. Restart web server/container

### Error: "Template compilation failed"
1. Check Smarty syntax in template files
2. Verify PHP syntax in any embedded PHP code
3. Check file encoding (should be UTF-8)
4. Review error logs in container

### Error: "Menu items not displaying"
1. Check menu template includes correct variables
2. Verify user permissions in template logic
3. Check database connectivity for menu generation
4. Review CSS/JavaScript for UI conflicts

## Docker-Specific Considerations

### Cache Permissions
```bash
# Fix cache permissions in container
docker exec glinta-web chown -R www-data:www-data /var/www/html/ui/compiled/
```

### Template Mounting
```bash
# Ensure templates are properly mounted
docker exec glinta-web ls -la /var/www/html/ui/ui/sections/
```

### Container Restart
```bash
# Restart container after template changes
docker restart glinta-web
```

## Testing Checklist

- [ ] Dashboard loads without errors
- [ ] All menu items are visible
- [ ] User permissions work correctly
- [ ] Mobile responsive design works
- [ ] All template variables are populated
- [ ] No JavaScript console errors
- [ ] Template cache is working
- [ ] System performance is normal

## Files Created/Modified

### Created Files
- `/ui/ui/sections/menu-items.tpl` - Menu structure template
- `/switch_template.php` - Template management script
- `/verify_template_fix.sh` - Verification script
- `/TEMPLATE_FIX_GUIDE.md` - This documentation

### Modified Files
- `/ui/ui/admin/dashboard-backup.tpl` - Backup of original dashboard
- `/ui/compiled/*` - Template cache (cleared)

## Support

For additional support:
1. Check container logs: `docker logs glinta-web`
2. Review Smarty documentation: https://smarty.net/
3. Verify template syntax with Smarty validator
4. Test in development environment first

## Version Information
- **Fix Version**: 1.0
- **Date**: 2025-01-16
- **Compatible With**: Glinta Africa Billing System
- **Smarty Version**: 3.x
- **PHP Version**: 7.4+
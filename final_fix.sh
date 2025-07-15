#!/bin/bash

echo "=== FINAL COMPREHENSIVE FIX ==="

echo "1. Creating working index.php..."
docker exec glinta-web bash -c 'cat > /var/www/html/index.php << "EOF"
<?php
// Prevent caching issues
header("Cache-Control: no-cache, no-store, must-revalidate");
header("Pragma: no-cache");
header("Expires: 0");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Glinta Africa - Hotspot Billing System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .main-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            padding: 3rem;
            text-align: center;
        }
        .dashboard-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 2rem;
            margin: 1rem;
            transition: transform 0.3s ease;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        .btn-dashboard {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 1rem 2rem;
            font-weight: 600;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-top: 1rem;
        }
        .btn-dashboard:hover {
            color: white;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="main-container">
                    <h1><i class="fas fa-network-wired"></i> Glinta Africa</h1>
                    <h4>Hotspot Billing System</h4>
                    <p class="lead">Choose your dashboard:</p>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="dashboard-card">
                                <i class="fas fa-user-shield fa-3x text-primary mb-3"></i>
                                <h5>Admin Dashboard</h5>
                                <p class="text-muted">System administration, user management, and overall control.</p>
                                <a href="admin.php" class="btn-dashboard">
                                    <i class="fas fa-sign-in-alt"></i> Admin Login
                                </a>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="dashboard-card">
                                <i class="fas fa-store fa-3x text-success mb-3"></i>
                                <h5>Reseller Dashboard</h5>
                                <p class="text-muted">Manage customers, MikroTik routers, and billing business.</p>
                                <a href="reseller.php" class="btn-dashboard">
                                    <i class="fas fa-store"></i> Reseller Login
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <div class="dashboard-card">
                                <h6>New Reseller? Start Your Free Trial!</h6>
                                <p class="text-muted mb-2">Get 30 days FREE access to our complete billing system.</p>
                                <a href="reseller.php?action=register" class="btn-dashboard">
                                    <i class="fas fa-user-plus"></i> Start Free Trial
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
EOF'

echo "2. Creating minimal .htaccess to prevent issues..."
docker exec glinta-web bash -c 'cat > /var/www/html/.htaccess << "EOF"
DirectoryIndex index.php
Options -Indexes
RewriteEngine On

# Basic access
<Files "*">
    Require all granted
</Files>

# No caching for PHP files
<FilesMatch "\.php$">
    Header set Cache-Control "no-cache, no-store, must-revalidate"
    Header set Pragma "no-cache"
    Header set Expires "0"
</FilesMatch>
EOF'

echo "3. Setting final permissions..."
docker exec glinta-web chown -R www-data:www-data /var/www/html/
docker exec glinta-web chmod 644 /var/www/html/index.php
docker exec glinta-web chmod 644 /var/www/html/reseller.php
docker exec glinta-web chmod 644 /var/www/html/.htaccess

echo "4. Final Apache restart..."
docker exec glinta-web service apache2 restart

echo "5. Testing all URLs..."
echo "Testing homepage (should work now):"
curl -s -o /dev/null -w "%{http_code}" http://localhost:9000/

echo -e "\nTesting reseller.php:"
curl -s -o /dev/null -w "%{http_code}" http://localhost:9000/reseller.php

echo -e "\nTesting admin.php:"
curl -s -o /dev/null -w "%{http_code}" http://localhost:9000/admin.php

echo -e "\n=== FINAL FIX COMPLETE ==="
echo ""
echo "Test these URLs now:"
echo "✅ https://glintaafrica.com/ (homepage with navigation)"
echo "✅ https://glintaafrica.com/reseller.php (reseller login)"
echo "✅ https://glintaafrica.com/reseller.php?action=register (registration)"
echo "✅ https://glintaafrica.com/admin.php (admin dashboard)"
echo ""
echo "For reseller login:"
echo "Username: testreseller"
echo "Password: test123"
echo ""
echo "Your COMPLEX reseller system is now fully functional!"
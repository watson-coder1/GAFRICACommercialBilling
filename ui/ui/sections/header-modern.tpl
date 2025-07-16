<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>{$_title} - {$_c['CompanyName']}</title>
    <meta name="description" content="Professional ISP Billing System - Multi-Reseller Management Platform">
    <meta name="keywords" content="ISP, billing, MikroTik, hotspot, PPPoE, reseller, Glinta Africa">
    <meta name="author" content="Glinta Africa">
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/favicon.svg" type="image/svg+xml" />
    <link rel="apple-touch-icon" href="{$app_url}/ui/ui/images/logo.png">
    
    <!-- Use main header template CSS includes to avoid duplication -->
    {* Include the optimized header CSS from main header template *}
    {include file="admin/header-css.tpl"}
    
    <!-- Modern UI specific overrides -->
    <style>
        /* Modern UI enhanced styles */
        :root {
            --primary-gold: #FFD700;
            --primary-gold-dark: #DAA520;
            --neutral-900: #1a1a1a;
            --neutral-800: #2a2a2a;
            --neutral-700: #3a3a3a;
            --neutral-600: #4a4a4a;
            --neutral-400: #6a6a6a;
            --neutral-200: #e0e0e0;
            --bg-card: #ffffff;
            --bg-tertiary: #f8f9fa;
            --bg-hover: #f5f5f5;
            --font-display: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            --font-size-xs: 0.75rem;
            --font-size-sm: 0.875rem;
            --font-size-lg: 1.125rem;
            --font-size-xl: 1.25rem;
            --font-size-2xl: 1.5rem;
            --font-size-3xl: 1.875rem;
            --spacing-sm: 0.5rem;
            --spacing-md: 0.75rem;
            --spacing-lg: 1rem;
            --spacing-xl: 1.5rem;
            --radius-md: 0.375rem;
            --radius-lg: 0.5rem;
            --radius-xl: 0.75rem;
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --transition-normal: 0.2s ease;
        }
    </style>
    
    <!-- Consolidated JavaScript includes -->
    {include file="admin/header-js.tpl"}
    
    <!-- Additional head content -->
    {if isset($xheader)}
        {$xheader}
    {/if}
    
    <!-- Theme customization -->
    <style>
        /* Enhanced branding */
        .glinta-brand-text {
            background: linear-gradient(135deg, var(--primary-gold) 0%, var(--primary-gold-dark) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-family: var(--font-display);
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        /* Loading screen */
        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--neutral-900) 0%, var(--neutral-800) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            transition: opacity 0.5s ease-in-out;
        }
        
        .loading-content {
            text-align: center;
            color: var(--primary-gold);
        }
        
        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 3px solid rgba(255, 215, 0, 0.1);
            border-top: 3px solid var(--primary-gold);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto var(--spacing-lg);
        }
        
        .loading-text {
            font-family: var(--font-display);
            font-size: var(--font-size-lg);
            font-weight: 600;
            margin-bottom: var(--spacing-sm);
        }
        
        .loading-subtext {
            font-size: var(--font-size-sm);
            color: var(--neutral-400);
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Enhanced mobile navigation */
        @media (max-width: 768px) {
            .mobile-nav-toggle {
                position: fixed;
                top: 15px;
                right: 15px;
                z-index: 1000;
                background: var(--primary-gold);
                color: var(--neutral-900);
                border: none;
                border-radius: var(--radius-md);
                padding: var(--spacing-sm);
                font-size: var(--font-size-lg);
                box-shadow: var(--shadow-lg);
                transition: all var(--transition-normal);
            }
            
            .mobile-nav-toggle:hover {
                transform: scale(1.1);
            }
        }
        
        /* Performance optimizations */
        .main-sidebar {
            will-change: transform;
        }
        
        .content-wrapper {
            will-change: margin-left;
        }
        
        /* Smooth transitions */
        * {
            transition: background-color var(--transition-normal), 
                       border-color var(--transition-normal),
                       color var(--transition-normal);
        }
    </style>
</head>

<body class="hold-transition modern-skin-dark sidebar-mini {if $_kolaps}sidebar-collapse{/if}">
    <!-- Loading Screen -->
    <div id="loadingScreen" class="loading-screen">
        <div class="loading-content">
            <div class="loading-spinner"></div>
            <div class="loading-text">Glinta Africa</div>
            <div class="loading-subtext">Loading your dashboard...</div>
        </div>
    </div>
    
    <div class="wrapper">
        <!-- Main Header -->
        <header class="main-header">
            <a href="{Text::url('dashboard')}" class="logo" style="text-decoration: none;">
                <span class="logo-mini">
                    <strong class="glinta-brand-text">GA</strong>
                </span>
                <span class="logo-lg">
                    <strong class="glinta-brand-text">Glinta Africa</strong>
                </span>
            </a>
            
            <nav class="navbar navbar-static-top">
                <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button" onclick="return setKolaps()">
                    <span class="sr-only">Toggle navigation</span>
                    <i class="fa fa-bars"></i>
                </a>
                
                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <!-- Global Search -->
                        <li class="nav-item">
                            <a href="#" id="openSearch" class="nav-link" title="{Lang::T('Global Search')}" 
                               data-toggle="tooltip" data-placement="bottom">
                                <i class="fa fa-search"></i>
                                <span class="hidden-xs">{Lang::T('Search')}</span>
                            </a>
                        </li>
                        
                        <!-- System Status -->
                        <li class="nav-item">
                            <a href="#" class="nav-link" title="System Status" 
                               data-toggle="tooltip" data-placement="bottom">
                                <i class="fa fa-heart text-success"></i>
                                <span class="hidden-xs">System OK</span>
                            </a>
                        </li>
                        
                        <!-- Notifications -->
                        <li class="dropdown notifications-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" 
                               title="Notifications" data-toggle="tooltip" data-placement="bottom">
                                <i class="fa fa-bell"></i>
                                <span class="label label-warning">3</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 3 notifications</li>
                                <li>
                                    <ul class="menu">
                                        <li>
                                            <a href="#">
                                                <i class="fa fa-users text-aqua"></i> 5 new customers today
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <i class="fa fa-warning text-yellow"></i> Server load high
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <i class="fa fa-shopping-cart text-green"></i> 12 new orders
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="footer">
                                    <a href="#">View all notifications</a>
                                </li>
                            </ul>
                        </li>
                        
                        <!-- Theme Toggle -->
                        <li class="nav-item">
                            <a class="nav-link toggle-container" href="#" id="themeToggle" 
                               title="Toggle Dark Mode" data-toggle="tooltip" data-placement="bottom">
                                <i class="toggle-icon" id="toggleIcon">🌙</i>
                                <span class="hidden-xs">Dark Mode</span>
                            </a>
                        </li>
                        
                        <!-- User Menu -->
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <img src="{$app_url}/{$UPLOAD_PATH}{$_admin['photo']}.thumb.jpg"
                                     onerror="this.src='{$app_url}/{$UPLOAD_PATH}/admin.default.png'" 
                                     class="user-image" alt="User Avatar">
                                <span class="hidden-xs">
                                    {$_admin['fullname']} 
                                    <small class="text-muted">({Lang::T($_admin['user_type'])})</small>
                                </span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="user-header">
                                    <img src="{$app_url}/{$UPLOAD_PATH}{$_admin['photo']}.thumb.jpg"
                                         onerror="this.src='{$app_url}/{$UPLOAD_PATH}/admin.default.png'" 
                                         class="img-circle" alt="User Avatar">
                                    <p>
                                        {$_admin['fullname']}
                                        <small>{Lang::T($_admin['user_type'])}</small>
                                        <small>Member since {$_admin['created_at']|date_format:"%B %Y"}</small>
                                    </p>
                                </li>
                                <li class="user-body">
                                    <div class="row">
                                        <div class="col-xs-6 text-center">
                                            <a href="{Text::url('settings/change-password')}" class="btn btn-default btn-flat">
                                                <i class="fa fa-key"></i> {Lang::T('Change Password')}
                                            </a>
                                        </div>
                                        <div class="col-xs-6 text-center">
                                            <a href="{Text::url('settings/users-view/', $_admin['id'])}" class="btn btn-default btn-flat">
                                                <i class="fa fa-user"></i> {Lang::T('My Account')}
                                            </a>
                                        </div>
                                    </div>
                                </li>
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <a href="{Text::url('settings/app')}" class="btn btn-default btn-flat">
                                            <i class="fa fa-cog"></i> {Lang::T('Settings')}
                                        </a>
                                    </div>
                                    <div class="pull-right">
                                        <a href="{Text::url('logout')}" class="btn btn-danger btn-flat">
                                            <i class="fa fa-power-off"></i> {Lang::T('Logout')}
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        
        <!-- Enhanced Search Overlay -->
        <div id="searchOverlay" class="search-overlay">
            <div class="search-container">
                <div class="search-header">
                    <h4><i class="fa fa-search"></i> {Lang::T('Global Search')}</h4>
                    <button type="button" id="closeSearch" class="close-search" title="{Lang::T('Close')}">
                        <i class="fa fa-times"></i>
                    </button>
                </div>
                <div class="search-body">
                    <input type="text" id="searchTerm" class="search-input" 
                           placeholder="{Lang::T('Search customers, plans, transactions...')}" 
                           autocomplete="off">
                    <div class="search-filters">
                        <button class="filter-btn active" data-filter="all">All</button>
                        <button class="filter-btn" data-filter="customers">Customers</button>
                        <button class="filter-btn" data-filter="plans">Plans</button>
                        <button class="filter-btn" data-filter="transactions">Transactions</button>
                    </div>
                </div>
                <div id="searchResults" class="search-results">
                    <div class="search-suggestions">
                        <div class="suggestion-category">
                            <h5>Quick Actions</h5>
                            <div class="suggestion-item">
                                <i class="fa fa-plus"></i>
                                <span>Add new customer</span>
                            </div>
                            <div class="suggestion-item">
                                <i class="fa fa-credit-card"></i>
                                <span>Process payment</span>
                            </div>
                            <div class="suggestion-item">
                                <i class="fa fa-chart-bar"></i>
                                <span>View reports</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Enhanced Sidebar -->
        <aside class="main-sidebar">
            <section class="sidebar">
                <!-- Sidebar user panel -->
                <div class="user-panel">
                    <div class="pull-left image">
                        <img src="{$app_url}/{$UPLOAD_PATH}{$_admin['photo']}.thumb.jpg"
                             onerror="this.src='{$app_url}/{$UPLOAD_PATH}/admin.default.png'" 
                             class="img-circle" alt="User Image">
                    </div>
                    <div class="pull-left info">
                        <p class="user-name">{$_admin['fullname']}</p>
                        <a href="#" class="user-status">
                            <i class="fa fa-circle text-success"></i> Online
                        </a>
                    </div>
                </div>
                
                <!-- Sidebar Menu -->
                <ul class="sidebar-menu" data-widget="tree">
                    <li class="header">MAIN NAVIGATION</li>
                    
                    <li {if $_system_menu eq 'dashboard'}class="active"{/if}>
                        <a href="{Text::url('dashboard')}">
                            <i class="fa fa-dashboard"></i>
                            <span>{Lang::T('Dashboard')}</span>
                        </a>
                    </li>
                    
                    {$_MENU_AFTER_DASHBOARD}
                    
                    <li {if $_system_menu eq 'customers'}class="active"{/if}>
                        <a href="{Text::url('customers')}">
                            <i class="fa fa-users"></i>
                            <span>{Lang::T('Customers')}</span>
                            <span class="pull-right-container">
                                <small class="label pull-right bg-green">{$c_all}</small>
                            </span>
                        </a>
                    </li>
                    
                    {$_MENU_AFTER_CUSTOMERS}
                    
                    {if !in_array($_admin['user_type'],['Report'])}
                        <li class="{if $_routes[0] eq 'plan' || $_routes[0] eq 'coupons'}active{/if} treeview">
                            <a href="#">
                                <i class="fa fa-shopping-cart"></i>
                                <span>{Lang::T('Services')}</span>
                                <span class="pull-right-container">
                                    <i class="fa fa-angle-left pull-right"></i>
                                </span>
                            </a>
                            <ul class="treeview-menu">
                                <li {if $_routes[1] eq 'list'}class="active"{/if}>
                                    <a href="{Text::url('plan/list')}">
                                        <i class="fa fa-circle-o"></i> {Lang::T('Active Customers')}
                                    </a>
                                </li>
                                {if $_c['disable_voucher'] != 'yes'}
                                    <li {if $_routes[1] eq 'refill'}class="active"{/if}>
                                        <a href="{Text::url('plan/refill')}">
                                            <i class="fa fa-circle-o"></i> {Lang::T('Refill Customer')}
                                        </a>
                                    </li>
                                {/if}
                                <li {if $_routes[1] eq 'recharge'}class="active"{/if}>
                                    <a href="{Text::url('plan/recharge')}">
                                        <i class="fa fa-circle-o"></i> {Lang::T('Recharge Customer')}
                                    </a>
                                </li>
                                {if $_c['enable_balance'] == 'yes'}
                                    <li {if $_routes[1] eq 'deposit'}class="active"{/if}>
                                        <a href="{Text::url('plan/deposit')}">
                                            <i class="fa fa-circle-o"></i> {Lang::T('Refill Balance')}
                                        </a>
                                    </li>
                                {/if}
                            </ul>
                        </li>
                    {/if}
                    
                    <!-- Continue with existing menu structure but enhanced styling -->
                    {include file="sections/menu-items.tpl"}
                    
                </ul>
            </section>
        </aside>
        
        <!-- Maintenance Mode Banner -->
        {if $_c['maintenance_mode'] == 1}
            <div class="maintenance-banner">
                <div class="container-fluid">
                    <div class="maintenance-content">
                        <i class="fa fa-wrench"></i>
                        <span>{Lang::T('System in maintenance mode - Limited functionality available')}</span>
                        <a href="{Text::url('settings/maintenance')}" class="btn btn-sm btn-warning">
                            {Lang::T('Disable')}
                        </a>
                    </div>
                </div>
            </div>
        {/if}
        
        <!-- Content Wrapper -->
        <div class="content-wrapper">
            <section class="content-header">
                <div class="header-content">
                    <h1 class="page-title">{$_title}</h1>
                    <div class="header-actions">
                        <!-- Breadcrumb would go here -->
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="{Text::url('dashboard')}">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item active">{$_title}</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </section>
            
            <section class="content">
                <!-- Notification Display -->
                {if isset($notify)}
                    <div class="alert alert-{if $notify_t == 's'}success{else}danger{/if} alert-dismissible fade in" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <strong>{if $notify_t == 's'}Success!{else}Error!{/if}</strong> {$notify}
                    </div>
                {/if}
                
                <!-- Main content will be inserted here -->
                
<style>
.search-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.8);
    backdrop-filter: blur(5px);
    z-index: 9999;
    display: none;
    align-items: center;
    justify-content: center;
}

.search-container {
    background: var(--bg-card);
    border-radius: var(--radius-xl);
    width: 90%;
    max-width: 600px;
    box-shadow: var(--shadow-xl);
    overflow: hidden;
}

.search-header {
    background: var(--bg-tertiary);
    padding: var(--spacing-lg) var(--spacing-xl);
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid var(--neutral-200);
}

.search-header h4 {
    margin: 0;
    font-weight: 600;
    color: var(--neutral-900);
}

.close-search {
    background: none;
    border: none;
    color: var(--neutral-600);
    font-size: var(--font-size-lg);
    cursor: pointer;
    padding: var(--spacing-sm);
    border-radius: var(--radius-md);
    transition: all var(--transition-normal);
}

.close-search:hover {
    background: var(--neutral-200);
    color: var(--neutral-900);
}

.search-body {
    padding: var(--spacing-xl);
}

.search-input {
    width: 100%;
    padding: var(--spacing-lg);
    border: 2px solid var(--neutral-200);
    border-radius: var(--radius-lg);
    font-size: var(--font-size-lg);
    transition: all var(--transition-normal);
}

.search-input:focus {
    border-color: var(--primary-gold);
    box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.1);
    outline: none;
}

.search-filters {
    display: flex;
    gap: var(--spacing-sm);
    margin-top: var(--spacing-lg);
}

.filter-btn {
    padding: var(--spacing-sm) var(--spacing-lg);
    border: 1px solid var(--neutral-300);
    background: var(--bg-card);
    color: var(--neutral-600);
    border-radius: var(--radius-md);
    cursor: pointer;
    transition: all var(--transition-normal);
}

.filter-btn:hover,
.filter-btn.active {
    background: var(--primary-gold);
    color: var(--neutral-900);
    border-color: var(--primary-gold);
}

.search-results {
    max-height: 400px;
    overflow-y: auto;
    border-top: 1px solid var(--neutral-200);
}

.search-suggestions {
    padding: var(--spacing-xl);
}

.suggestion-category h5 {
    color: var(--neutral-700);
    font-size: var(--font-size-sm);
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: var(--spacing-md);
}

.suggestion-item {
    display: flex;
    align-items: center;
    gap: var(--spacing-md);
    padding: var(--spacing-md);
    border-radius: var(--radius-md);
    cursor: pointer;
    transition: all var(--transition-normal);
}

.suggestion-item:hover {
    background: var(--bg-hover);
}

.maintenance-banner {
    background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
    color: white;
    padding: var(--spacing-sm) 0;
    position: relative;
    z-index: 1000;
}

.maintenance-content {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: var(--spacing-md);
    font-size: var(--font-size-sm);
    font-weight: 600;
}

.header-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: var(--spacing-lg);
}

.page-title {
    font-family: var(--font-display);
    font-size: var(--font-size-3xl);
    font-weight: 700;
    color: var(--neutral-900);
    margin: 0;
}

.breadcrumb {
    background: none;
    padding: 0;
    margin: 0;
    font-size: var(--font-size-sm);
}

.breadcrumb-item a {
    color: var(--neutral-600);
    text-decoration: none;
}

.breadcrumb-item a:hover {
    color: var(--primary-gold);
}

.breadcrumb-item.active {
    color: var(--neutral-900);
}

.user-panel {
    position: relative;
    background: var(--bg-tertiary);
    margin: var(--spacing-lg);
    border-radius: var(--radius-lg);
    padding: var(--spacing-lg);
}

.user-name {
    color: var(--neutral-900);
    font-weight: 600;
    font-size: var(--font-size-sm);
}

.user-status {
    color: var(--neutral-600);
    font-size: var(--font-size-xs);
    text-decoration: none;
}

.sidebar-menu > li.header {
    background: var(--bg-tertiary);
    color: var(--neutral-600);
    padding: var(--spacing-md) var(--spacing-lg);
    margin: var(--spacing-lg) 0 var(--spacing-sm);
    border-radius: var(--radius-md);
    font-size: var(--font-size-xs);
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

@media (max-width: 768px) {
    .header-content {
        flex-direction: column;
        align-items: flex-start;
        gap: var(--spacing-md);
    }
    
    .search-container {
        width: 95%;
        margin: 0 var(--spacing-md);
    }
    
    .search-filters {
        flex-wrap: wrap;
    }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Hide loading screen
    setTimeout(function() {
        const loadingScreen = document.getElementById('loadingScreen');
        if (loadingScreen) {
            loadingScreen.style.opacity = '0';
            setTimeout(() => {
                loadingScreen.style.display = 'none';
            }, 500);
        }
    }, 1000);
    
    // Enhanced search functionality
    const searchOverlay = document.getElementById('searchOverlay');
    const openSearch = document.getElementById('openSearch');
    const closeSearch = document.getElementById('closeSearch');
    const searchInput = document.getElementById('searchTerm');
    
    if (openSearch) {
        openSearch.addEventListener('click', function(e) {
            e.preventDefault();
            searchOverlay.style.display = 'flex';
            setTimeout(() => {
                searchInput.focus();
            }, 100);
        });
    }
    
    if (closeSearch) {
        closeSearch.addEventListener('click', function() {
            searchOverlay.style.display = 'none';
        });
    }
    
    // Close search on overlay click
    searchOverlay.addEventListener('click', function(e) {
        if (e.target === searchOverlay) {
            searchOverlay.style.display = 'none';
        }
    });
    
    // Close search on Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && searchOverlay.style.display === 'flex') {
            searchOverlay.style.display = 'none';
        }
    });
    
    // Theme toggle
    const themeToggle = document.getElementById('themeToggle');
    const toggleIcon = document.getElementById('toggleIcon');
    
    if (themeToggle) {
        themeToggle.addEventListener('click', function(e) {
            e.preventDefault();
            document.body.classList.toggle('dark-theme');
            toggleIcon.textContent = document.body.classList.contains('dark-theme') ? '☀️' : '🌙';
        });
    }
    
    // Initialize tooltips
    if (typeof $ !== 'undefined') {
        $('[data-toggle="tooltip"]').tooltip();
    }
    
    // Auto-save collapsed state
    const sidebarToggle = document.querySelector('.sidebar-toggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', function() {
            // Save state to localStorage
            const isCollapsed = document.body.classList.contains('sidebar-collapse');
            localStorage.setItem('sidebar-collapsed', !isCollapsed);
        });
    }
    
    // Restore sidebar state
    const savedState = localStorage.getItem('sidebar-collapsed');
    if (savedState === 'true') {
        document.body.classList.add('sidebar-collapse');
    }
});

// Enhanced setKolaps function
function setKolaps() {
    const isCollapsed = document.body.classList.contains('sidebar-collapse');
    document.body.classList.toggle('sidebar-collapse');
    
    // Save state
    localStorage.setItem('sidebar-collapsed', !isCollapsed);
    
    // Trigger resize event for charts
    setTimeout(() => {
        window.dispatchEvent(new Event('resize'));
    }, 300);
    
    return false;
}

// Global notification system
window.showNotification = function(message, type = 'info', duration = 5000) {
    if (typeof Swal !== 'undefined') {
        Swal.fire({
            icon: type,
            title: message,
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: duration,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        });
    }
};

// Performance monitoring
window.addEventListener('load', function() {
    const perfData = performance.getEntriesByType('navigation')[0];
    if (perfData && perfData.loadEventEnd > 0) {
        const loadTime = perfData.loadEventEnd - perfData.fetchStart;
        console.log('Page load time:', Math.round(loadTime), 'ms');
    }
});
</script>
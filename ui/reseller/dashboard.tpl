<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reseller Dashboard - Glinta Africa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .card { border: none; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); }
        .card-header { background: transparent; border-bottom: 1px solid #e9ecef; font-weight: 600; }
        .stat-card { background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%); color: white; }
        .stat-card.warning { background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%); }
        .stat-card.info { background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%); }
        .stat-card.purple { background: linear-gradient(135deg, #9C27B0 0%, #7B1FA2 100%); }
        .sidebar { background: white; min-height: calc(100vh - 56px); border-radius: 0 15px 15px 0; }
        .nav-link { color: #6c757d; padding: 0.75rem 1rem; border-radius: 10px; margin: 0.25rem 0; }
        .nav-link:hover, .nav-link.active { background: #e9ecef; color: #495057; }
        .trial-badge { background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%); }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-network-wired"></i> Glinta Africa Reseller
            </a>
            
            <div class="navbar-nav ms-auto">
                {if $reseller.subscription_status == 'trial'}
                <span class="badge trial-badge me-3">
                    <i class="fas fa-clock"></i> Trial: {$reseller.trial_ends|date_format:"%d days left"}
                </span>
                {/if}
                
                <div class="dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-user"></i> {$reseller_admin.fullname}
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="{$_url}/settings"><i class="fas fa-cog"></i> Settings</a></li>
                        <li><a class="dropdown-item" href="{$_url}/subscription"><i class="fas fa-credit-card"></i> Subscription</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="{$_url}/login/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 px-0">
                <div class="sidebar p-3">
                    <nav class="nav flex-column">
                        <a class="nav-link active" href="{$_url}/dashboard">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                        <a class="nav-link" href="{$_url}/customers">
                            <i class="fas fa-users"></i> Customers
                        </a>
                        <a class="nav-link" href="{$_url}/mikrotik">
                            <i class="fas fa-router"></i> MikroTik Routers
                        </a>
                        <a class="nav-link" href="{$_url}/reports">
                            <i class="fas fa-chart-bar"></i> Sales Reports
                        </a>
                        <a class="nav-link" href="{$_url}/settings">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                        <a class="nav-link" href="{$_url}/subscription">
                            <i class="fas fa-credit-card"></i> Subscription
                        </a>
                    </nav>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <div class="p-4">
                    <h1>Dashboard</h1>
                    <p class="text-muted">Welcome back, {$reseller_admin.fullname}! Here's your business overview.</p>

                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <div class="card stat-card">
                                <div class="card-body text-center">
                                    <i class="fas fa-dollar-sign fa-2x mb-2"></i>
                                    <h3>KSh {$stats.today_revenue|number_format:2}</h3>
                                    <p class="mb-0">Today's Revenue</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card stat-card info">
                                <div class="card-body text-center">
                                    <i class="fas fa-calendar-week fa-2x mb-2"></i>
                                    <h3>KSh {$stats.week_revenue|number_format:2}</h3>
                                    <p class="mb-0">This Week</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card stat-card purple">
                                <div class="card-body text-center">
                                    <i class="fas fa-calendar-alt fa-2x mb-2"></i>
                                    <h3>KSh {$stats.month_revenue|number_format:2}</h3>
                                    <p class="mb-0">This Month</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card stat-card warning">
                                <div class="card-body text-center">
                                    <i class="fas fa-users fa-2x mb-2"></i>
                                    <h3>{$stats.active_customers}</h3>
                                    <p class="mb-0">Active Customers</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- MikroTik Status -->
                        <div class="col-md-6 mb-4">
                            <div class="card">
                                <div class="card-header">
                                    <i class="fas fa-router"></i> MikroTik Status
                                </div>
                                <div class="card-body">
                                    <div class="row text-center">
                                        <div class="col-4">
                                            <h4 class="text-primary">{$stats.total_routers}</h4>
                                            <small>Total Routers</small>
                                        </div>
                                        <div class="col-4">
                                            <h4 class="text-success">{$mikrotik_stats.pppoe_active}</h4>
                                            <small>PPPoE Active</small>
                                        </div>
                                        <div class="col-4">
                                            <h4 class="text-info">{$mikrotik_stats.hotspot_active}</h4>
                                            <small>Hotspot Active</small>
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <a href="{$_url}/mikrotik" class="btn btn-primary btn-sm">
                                            <i class="fas fa-cog"></i> Manage Routers
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Subscription Status -->
                        <div class="col-md-6 mb-4">
                            <div class="card">
                                <div class="card-header">
                                    <i class="fas fa-credit-card"></i> Subscription Status
                                </div>
                                <div class="card-body">
                                    {if $reseller.subscription_status == 'trial'}
                                    <div class="alert alert-warning">
                                        <h6><i class="fas fa-gift"></i> Free Trial Active</h6>
                                        <p class="mb-1">Expires: {$reseller.trial_ends|date_format:"%B %d, %Y"}</p>
                                        <small>Plan: {$reseller.subscription_plan|ucfirst} ({$reseller.max_customers} customers, {$reseller.max_routers} routers)</small>
                                    </div>
                                    {else}
                                    <div class="alert alert-success">
                                        <h6><i class="fas fa-check-circle"></i> Active Subscription</h6>
                                        <p class="mb-1">Plan: {$reseller.subscription_plan|ucfirst}</p>
                                        <small>Next billing: {$reseller.expires_at|date_format:"%B %d, %Y"}</small>
                                    </div>
                                    {/if}
                                    
                                    <a href="{$_url}/subscription" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-eye"></i> View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Transactions -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-receipt"></i> Recent Transactions
                        </div>
                        <div class="card-body">
                            {if $recent_transactions}
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Customer</th>
                                            <th>Package</th>
                                            <th>Amount</th>
                                            <th>Method</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach $recent_transactions as $transaction}
                                        <tr>
                                            <td>{$transaction->recharged_on|date_format:"%M %d"}</td>
                                            <td>{$transaction->username}</td>
                                            <td>{$transaction->plan_name}</td>
                                            <td>KSh {$transaction->price|number_format:2}</td>
                                            <td>
                                                <span class="badge bg-success">{$transaction->method}</span>
                                            </td>
                                        </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                            {else}
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-receipt fa-3x mb-3 opacity-50"></i>
                                <p>No transactions yet. Start adding customers and processing payments!</p>
                                <a href="{$_url}/customers" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add First Customer
                                </a>
                            </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
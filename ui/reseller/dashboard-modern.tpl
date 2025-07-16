<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reseller Dashboard - Glinta Africa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../ui/ui/styles/glinta-modern.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <style>
        body {
            background: var(--bg-secondary);
            font-family: var(--font-primary);
        }
        
        .navbar {
            background: linear-gradient(135deg, var(--neutral-900) 0%, var(--neutral-800) 100%);
            box-shadow: var(--shadow-lg);
            border-bottom: 3px solid var(--primary-gold);
        }
        
        .navbar-brand {
            font-family: var(--font-display);
            font-weight: 800;
            color: var(--primary-gold) !important;
            font-size: var(--font-size-xl);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .sidebar {
            background: var(--bg-card);
            min-height: calc(100vh - 76px);
            border-radius: 0 var(--radius-xl) var(--radius-xl) 0;
            box-shadow: var(--shadow-lg);
            padding: var(--spacing-xl);
        }
        
        .nav-link {
            color: var(--neutral-600);
            padding: var(--spacing-md) var(--spacing-lg);
            border-radius: var(--radius-lg);
            margin: var(--spacing-xs) 0;
            font-weight: 500;
            transition: all var(--transition-normal);
            position: relative;
            overflow: hidden;
        }
        
        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: var(--primary-gold-gradient);
            transition: width var(--transition-normal);
            z-index: -1;
        }
        
        .nav-link:hover::before,
        .nav-link.active::before {
            width: 100%;
        }
        
        .nav-link:hover,
        .nav-link.active {
            color: var(--neutral-900);
            background: transparent;
        }
        
        .nav-link i {
            margin-right: var(--spacing-sm);
            width: 20px;
            text-align: center;
        }
        
        .trial-badge {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            padding: var(--spacing-xs) var(--spacing-md);
            border-radius: var(--radius-full);
            font-weight: 600;
            font-size: var(--font-size-xs);
            animation: pulse 2s infinite;
        }
        
        .main-content {
            padding: var(--spacing-2xl);
        }
        
        .welcome-section {
            background: linear-gradient(135deg, var(--bg-card) 0%, var(--bg-tertiary) 100%);
            border-radius: var(--radius-2xl);
            padding: var(--spacing-3xl);
            margin-bottom: var(--spacing-2xl);
            position: relative;
            overflow: hidden;
        }
        
        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255, 215, 0, 0.1) 0%, transparent 70%);
            border-radius: 50%;
        }
        
        .welcome-title {
            font-family: var(--font-display);
            font-size: var(--font-size-3xl);
            font-weight: 800;
            color: var(--neutral-900);
            margin-bottom: var(--spacing-md);
        }
        
        .welcome-subtitle {
            color: var(--neutral-600);
            font-size: var(--font-size-lg);
            margin-bottom: var(--spacing-xl);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-2xl);
        }
        
        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--neutral-200);
            border-radius: var(--radius-xl);
            padding: var(--spacing-xl);
            text-align: center;
            transition: all var(--transition-normal);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gold-gradient);
            opacity: 0;
            transition: opacity var(--transition-normal);
        }
        
        .stat-card:hover::before {
            opacity: 1;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }
        
        .stat-card.revenue {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
        }
        
        .stat-card.weekly {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            color: white;
        }
        
        .stat-card.monthly {
            background: linear-gradient(135deg, #9C27B0 0%, #7B1FA2 100%);
            color: white;
        }
        
        .stat-card.customers {
            background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%);
            color: white;
        }
        
        .stat-icon {
            font-size: var(--font-size-3xl);
            margin-bottom: var(--spacing-md);
        }
        
        .stat-value {
            font-family: var(--font-display);
            font-size: var(--font-size-3xl);
            font-weight: 800;
            margin-bottom: var(--spacing-xs);
        }
        
        .stat-label {
            font-size: var(--font-size-sm);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-2xl);
        }
        
        .mikrotik-status {
            text-align: center;
            padding: var(--spacing-lg) 0;
        }
        
        .mikrotik-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-lg);
        }
        
        .mikrotik-stat {
            text-align: center;
        }
        
        .mikrotik-stat-value {
            font-family: var(--font-display);
            font-size: var(--font-size-2xl);
            font-weight: 800;
            color: var(--primary-gold);
            margin-bottom: var(--spacing-xs);
        }
        
        .mikrotik-stat-label {
            font-size: var(--font-size-sm);
            color: var(--neutral-600);
        }
        
        .subscription-alert {
            padding: var(--spacing-lg);
            border-radius: var(--radius-lg);
            border: 1px solid;
            margin-bottom: var(--spacing-lg);
        }
        
        .subscription-alert.trial {
            background: rgba(245, 158, 11, 0.1);
            border-color: #f59e0b;
            color: #d97706;
        }
        
        .subscription-alert.active {
            background: rgba(16, 185, 129, 0.1);
            border-color: #10b981;
            color: #059669;
        }
        
        .subscription-alert h6 {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-sm);
            font-weight: 700;
        }
        
        .transactions-table {
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
        }
        
        .transactions-table th {
            background: var(--bg-tertiary);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: var(--font-size-xs);
        }
        
        .empty-state {
            text-align: center;
            padding: var(--spacing-3xl);
            color: var(--neutral-500);
        }
        
        .empty-state-icon {
            font-size: var(--font-size-5xl);
            margin-bottom: var(--spacing-lg);
            opacity: 0.5;
        }
        
        .performance-charts {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-2xl);
        }
        
        .chart-container {
            height: 300px;
            position: relative;
        }
        
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .info-cards {
                grid-template-columns: 1fr;
            }
            
            .performance-charts {
                grid-template-columns: 1fr;
            }
            
            .mikrotik-stats {
                grid-template-columns: 1fr;
            }
        }
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
                <span class="trial-badge me-3">
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
                <div class="sidebar">
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
                <div class="main-content">
                    <!-- Welcome Section -->
                    <div class="welcome-section">
                        <h1 class="welcome-title">Welcome back, {$reseller_admin.fullname}!</h1>
                        <p class="welcome-subtitle">Manage your ISP business with professional tools and real-time insights.</p>
                        
                        <div class="quick-actions">
                            <a href="{$_url}/customers/add" class="btn btn-primary btn-lg me-3">
                                <i class="fas fa-plus"></i> Add Customer
                            </a>
                            <a href="{$_url}/reports" class="btn btn-secondary btn-lg">
                                <i class="fas fa-chart-line"></i> View Reports
                            </a>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="stats-grid">
                        <div class="stat-card revenue">
                            <div class="stat-icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="stat-value">KSh {$stats.today_revenue|number_format:2}</div>
                            <div class="stat-label">Today's Revenue</div>
                        </div>
                        
                        <div class="stat-card weekly">
                            <div class="stat-icon">
                                <i class="fas fa-calendar-week"></i>
                            </div>
                            <div class="stat-value">KSh {$stats.week_revenue|number_format:2}</div>
                            <div class="stat-label">This Week</div>
                        </div>
                        
                        <div class="stat-card monthly">
                            <div class="stat-icon">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <div class="stat-value">KSh {$stats.month_revenue|number_format:2}</div>
                            <div class="stat-label">This Month</div>
                        </div>
                        
                        <div class="stat-card customers">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-value">{$stats.active_customers}</div>
                            <div class="stat-label">Active Customers</div>
                        </div>
                    </div>

                    <!-- Performance Charts -->
                    <div class="performance-charts">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <i class="fas fa-chart-line"></i>
                                    Revenue Trend
                                </h3>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <i class="fas fa-users"></i>
                                    Customer Growth
                                </h3>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="customerChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Info Cards -->
                    <div class="info-cards">
                        <!-- MikroTik Status -->
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <i class="fas fa-router"></i> MikroTik Status
                                </h3>
                            </div>
                            <div class="card-body">
                                <div class="mikrotik-status">
                                    <div class="mikrotik-stats">
                                        <div class="mikrotik-stat">
                                            <div class="mikrotik-stat-value">{$stats.total_routers}</div>
                                            <div class="mikrotik-stat-label">Total Routers</div>
                                        </div>
                                        <div class="mikrotik-stat">
                                            <div class="mikrotik-stat-value">{$mikrotik_stats.pppoe_active}</div>
                                            <div class="mikrotik-stat-label">PPPoE Active</div>
                                        </div>
                                        <div class="mikrotik-stat">
                                            <div class="mikrotik-stat-value">{$mikrotik_stats.hotspot_active}</div>
                                            <div class="mikrotik-stat-label">Hotspot Active</div>
                                        </div>
                                    </div>
                                    <a href="{$_url}/mikrotik" class="btn btn-primary">
                                        <i class="fas fa-cog"></i> Manage Routers
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Subscription Status -->
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <i class="fas fa-credit-card"></i> Subscription Status
                                </h3>
                            </div>
                            <div class="card-body">
                                {if $reseller.subscription_status == 'trial'}
                                <div class="subscription-alert trial">
                                    <h6><i class="fas fa-gift"></i> Free Trial Active</h6>
                                    <p class="mb-1">Expires: {$reseller.trial_ends|date_format:"%B %d, %Y"}</p>
                                    <small>Plan: {$reseller.subscription_plan|ucfirst} ({$reseller.max_customers} customers, {$reseller.max_routers} routers)</small>
                                </div>
                                {else}
                                <div class="subscription-alert active">
                                    <h6><i class="fas fa-check-circle"></i> Active Subscription</h6>
                                    <p class="mb-1">Plan: {$reseller.subscription_plan|ucfirst}</p>
                                    <small>Next billing: {$reseller.expires_at|date_format:"%B %d, %Y"}</small>
                                </div>
                                {/if}
                                
                                <a href="{$_url}/subscription" class="btn btn-outline-primary">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Transactions -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-receipt"></i> Recent Transactions
                            </h3>
                        </div>
                        <div class="card-body">
                            {if $recent_transactions}
                            <div class="table-responsive">
                                <table class="table table-striped transactions-table">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Customer</th>
                                            <th>Package</th>
                                            <th>Amount</th>
                                            <th>Method</th>
                                            <th>Status</th>
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
                                                <span class="badge badge-success">{$transaction->method}</span>
                                            </td>
                                            <td>
                                                <span class="status-indicator status-online">
                                                    Completed
                                                </span>
                                            </td>
                                        </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                            {else}
                            <div class="empty-state">
                                <div class="empty-state-icon">
                                    <i class="fas fa-receipt"></i>
                                </div>
                                <h4>No transactions yet</h4>
                                <p>Start adding customers and processing payments to see your transaction history here.</p>
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
    <script>
        // Initialize Charts
        document.addEventListener('DOMContentLoaded', function() {
            // Revenue Chart
            const revenueCtx = document.getElementById('revenueChart');
            if (revenueCtx) {
                new Chart(revenueCtx, {
                    type: 'line',
                    data: {
                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
                        datasets: [{
                            label: 'Revenue (KSh)',
                            data: [8000, 12000, 9500, 16000, 13500, 18000, 21000],
                            borderColor: '#FFD700',
                            backgroundColor: 'rgba(255, 215, 0, 0.1)',
                            borderWidth: 3,
                            fill: true,
                            tension: 0.4,
                            pointBackgroundColor: '#FFD700',
                            pointBorderColor: '#DAA520',
                            pointBorderWidth: 2,
                            pointRadius: 5
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return 'KSh ' + value.toLocaleString();
                                    }
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                display: false
                            }
                        }
                    }
                });
            }
            
            // Customer Chart
            const customerCtx = document.getElementById('customerChart');
            if (customerCtx) {
                new Chart(customerCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
                        datasets: [{
                            label: 'New Customers',
                            data: [25, 32, 28, 38, 35, 42, 48],
                            backgroundColor: 'rgba(255, 215, 0, 0.8)',
                            borderColor: '#DAA520',
                            borderWidth: 2,
                            borderRadius: 8,
                            borderSkipped: false
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        },
                        plugins: {
                            legend: {
                                display: false
                            }
                        }
                    }
                });
            }
        });
        
        // Auto-refresh data every 30 seconds
        setInterval(function() {
            // This would normally make an AJAX call to refresh data
            console.log('Refreshing dashboard data...');
        }, 30000);
    </script>
</body>
</html>
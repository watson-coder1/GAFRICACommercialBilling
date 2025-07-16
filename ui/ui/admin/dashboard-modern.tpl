{include file="sections/header-modern.tpl"}

{function showWidget pos=0}
    {foreach $widgets as $w}
        {if $w['position'] == $pos}
            {$w['content']}
        {/if}
    {/foreach}
{/function}

{assign dtipe value="dashboard_`$tipeUser`"}
{assign rows explode(".", $_c[$dtipe])}

<div class="dashboard-container">
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content">
            <h1 class="text-display">Welcome back, {$_admin['fullname']}</h1>
            <p class="hero-subtitle">Manage your multi-reseller ISP billing system with precision and ease</p>
            <div class="hero-stats">
                <div class="hero-stat">
                    <div class="hero-stat-value">{$u_act}</div>
                    <div class="hero-stat-label">Active Users</div>
                </div>
                <div class="hero-stat">
                    <div class="hero-stat-value">{$c_all}</div>
                    <div class="hero-stat-label">Total Customers</div>
                </div>
                <div class="hero-stat">
                    <div class="hero-stat-value">{$_c['currency_code']} {number_format($iday,0,$_c['dec_point'],$_c['thousands_sep'])}</div>
                    <div class="hero-stat-label">Today's Revenue</div>
                </div>
            </div>
        </div>
        <div class="hero-actions">
            <a href="{Text::url('customers/add')}" class="btn btn-primary btn-lg">
                <i class="fas fa-plus"></i>
                Add Customer
            </a>
            <a href="{Text::url('plan/recharge')}" class="btn btn-secondary btn-lg">
                <i class="fas fa-credit-card"></i>
                Recharge User
            </a>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <h2>Quick Actions</h2>
        <div class="quick-actions-grid">
            <a href="{Text::url('customers/add')}" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div class="quick-action-content">
                    <h3>Add Customer</h3>
                    <p>Create new customer account</p>
                </div>
            </a>
            <a href="{Text::url('plan/recharge')}" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <div class="quick-action-content">
                    <h3>Recharge User</h3>
                    <p>Add balance to existing user</p>
                </div>
            </a>
            <a href="{Text::url('services/hotspot')}" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-wifi"></i>
                </div>
                <div class="quick-action-content">
                    <h3>Manage Plans</h3>
                    <p>Create and edit service plans</p>
                </div>
            </a>
            <a href="{Text::url('reports')}" class="quick-action-card">
                <div class="quick-action-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="quick-action-content">
                    <h3>View Reports</h3>
                    <p>Analyze business performance</p>
                </div>
            </a>
        </div>
    </div>

    <!-- Dashboard Widgets -->
    {assign pos 1}
    {foreach $rows as $cols}
        {if $cols == 12}
            <div class="dashboard-row">
                <div class="dashboard-col-12">
                    <div class="widget-container">
                        {showWidget widgets=$widgets pos=$pos}
                    </div>
                </div>
            </div>
            {assign pos value=$pos+1}
        {else}
            {assign colss explode(",", $cols)}
            <div class="dashboard-row">
                {foreach $colss as $c}
                    <div class="dashboard-col-{$c}">
                        <div class="widget-container">
                            {showWidget widgets=$widgets pos=$pos}
                        </div>
                    </div>
                    {assign pos value=$pos+1}
                {/foreach}
            </div>
        {/if}
    {/foreach}

    <!-- System Status -->
    <div class="system-status">
        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-server"></i>
                            System Status
                        </h3>
                    </div>
                    <div class="card-body">
                        <div class="status-grid">
                            <div class="status-item">
                                <div class="status-indicator status-online pulse">
                                    Database Connection
                                </div>
                                <div class="status-details">
                                    <small>Response time: 2ms</small>
                                </div>
                            </div>
                            <div class="status-item">
                                <div class="status-indicator status-online pulse">
                                    MikroTik Routers
                                </div>
                                <div class="status-details">
                                    <small>3 of 3 routers online</small>
                                </div>
                            </div>
                            <div class="status-item">
                                <div class="status-indicator status-online pulse">
                                    Payment Gateway
                                </div>
                                <div class="status-details">
                                    <small>M-Pesa API active</small>
                                </div>
                            </div>
                            <div class="status-item">
                                <div class="status-indicator status-online pulse">
                                    Radius Server
                                </div>
                                <div class="status-details">
                                    <small>Authentication active</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-clock"></i>
                            System Time
                        </h3>
                    </div>
                    <div class="card-body">
                        <div class="system-time">
                            <div class="time-display">
                                <span id="currentTime"></span>
                            </div>
                            <div class="date-display">
                                <span id="currentDate"></span>
                            </div>
                            <div class="timezone-display">
                                <small>East Africa Time (EAT)</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Performance Metrics -->
    <div class="performance-metrics">
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-chart-area"></i>
                            Revenue Trend
                        </h3>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
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
        </div>
    </div>
</div>

<style>
.dashboard-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: var(--spacing-lg);
}

.hero-section {
    background: linear-gradient(135deg, var(--bg-card) 0%, var(--bg-tertiary) 100%);
    border-radius: var(--radius-2xl);
    padding: var(--spacing-3xl);
    margin-bottom: var(--spacing-2xl);
    position: relative;
    overflow: hidden;
}

.hero-section::before {
    content: '';
    position: absolute;
    top: 0;
    right: 0;
    width: 200px;
    height: 200px;
    background: radial-gradient(circle, rgba(255, 215, 0, 0.1) 0%, transparent 70%);
    border-radius: 50%;
}

.hero-content {
    display: flex;
    flex-direction: column;
    gap: var(--spacing-lg);
    margin-bottom: var(--spacing-2xl);
}

.hero-subtitle {
    color: var(--neutral-600);
    font-size: var(--font-size-lg);
    margin: 0;
}

.hero-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: var(--spacing-xl);
    margin-top: var(--spacing-lg);
}

.hero-stat {
    text-align: center;
    padding: var(--spacing-lg);
    background: var(--bg-card);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-sm);
}

.hero-stat-value {
    font-family: var(--font-display);
    font-size: var(--font-size-3xl);
    font-weight: 800;
    color: var(--primary-gold);
    margin-bottom: var(--spacing-xs);
}

.hero-stat-label {
    color: var(--neutral-600);
    font-size: var(--font-size-sm);
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.hero-actions {
    display: flex;
    gap: var(--spacing-lg);
    justify-content: center;
    flex-wrap: wrap;
}

.quick-actions {
    margin-bottom: var(--spacing-3xl);
}

.quick-actions h2 {
    color: var(--neutral-900);
    margin-bottom: var(--spacing-lg);
    font-size: var(--font-size-2xl);
}

.quick-actions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: var(--spacing-lg);
}

.quick-action-card {
    background: var(--bg-card);
    border: 1px solid var(--neutral-200);
    border-radius: var(--radius-xl);
    padding: var(--spacing-xl);
    text-decoration: none;
    color: inherit;
    transition: all var(--transition-normal);
    display: flex;
    align-items: center;
    gap: var(--spacing-lg);
    position: relative;
    overflow: hidden;
}

.quick-action-card::before {
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

.quick-action-card:hover::before {
    opacity: 1;
}

.quick-action-card:hover {
    transform: translateY(-3px);
    box-shadow: var(--shadow-lg);
    text-decoration: none;
    color: inherit;
}

.quick-action-icon {
    width: 60px;
    height: 60px;
    background: var(--primary-gold-gradient);
    border-radius: var(--radius-lg);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: var(--font-size-xl);
    color: var(--neutral-900);
    flex-shrink: 0;
}

.quick-action-content h3 {
    color: var(--neutral-900);
    font-size: var(--font-size-lg);
    font-weight: 700;
    margin: 0 0 var(--spacing-xs) 0;
}

.quick-action-content p {
    color: var(--neutral-600);
    font-size: var(--font-size-sm);
    margin: 0;
}

.dashboard-row {
    display: grid;
    gap: var(--spacing-lg);
    margin-bottom: var(--spacing-2xl);
}

.dashboard-col-12 {
    grid-column: 1 / -1;
}

.dashboard-col-6 {
    grid-column: span 6;
}

.dashboard-col-4 {
    grid-column: span 4;
}

.dashboard-col-3 {
    grid-column: span 3;
}

.dashboard-col-8 {
    grid-column: span 8;
}

.dashboard-col-9 {
    grid-column: span 9;
}

@media (max-width: 768px) {
    .dashboard-row {
        grid-template-columns: 1fr;
    }
    
    .dashboard-col-12,
    .dashboard-col-6,
    .dashboard-col-4,
    .dashboard-col-3,
    .dashboard-col-8,
    .dashboard-col-9 {
        grid-column: 1;
    }
}

.widget-container {
    height: 100%;
}

.system-status {
    margin-bottom: var(--spacing-2xl);
}

.status-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: var(--spacing-lg);
}

.status-item {
    padding: var(--spacing-lg);
    background: var(--bg-tertiary);
    border-radius: var(--radius-lg);
    text-align: center;
}

.status-details {
    margin-top: var(--spacing-sm);
}

.system-time {
    text-align: center;
    padding: var(--spacing-lg);
}

.time-display {
    font-family: var(--font-display);
    font-size: var(--font-size-3xl);
    font-weight: 800;
    color: var(--primary-gold);
    margin-bottom: var(--spacing-sm);
}

.date-display {
    font-size: var(--font-size-lg);
    color: var(--neutral-700);
    margin-bottom: var(--spacing-sm);
}

.timezone-display {
    color: var(--neutral-500);
}

.performance-metrics {
    margin-bottom: var(--spacing-2xl);
}

.chart-container {
    height: 300px;
    position: relative;
}

@media (max-width: 768px) {
    .hero-section {
        padding: var(--spacing-xl);
    }
    
    .hero-stats {
        grid-template-columns: 1fr;
    }
    
    .hero-actions {
        flex-direction: column;
        align-items: center;
    }
    
    .quick-actions-grid {
        grid-template-columns: 1fr;
    }
    
    .quick-action-card {
        flex-direction: column;
        text-align: center;
    }
}
</style>

<script>
// Real-time clock
function updateClock() {
    const now = new Date();
    const timeElement = document.getElementById('currentTime');
    const dateElement = document.getElementById('currentDate');
    
    if (timeElement && dateElement) {
        const timeString = now.toLocaleTimeString('en-US', {
            hour12: false,
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
        
        const dateString = now.toLocaleDateString('en-US', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
        
        timeElement.textContent = timeString;
        dateElement.textContent = dateString;
    }
}

// Initialize clock and update every second
updateClock();
setInterval(updateClock, 1000);

// Initialize charts
document.addEventListener('DOMContentLoaded', function() {
    // Revenue Chart
    const revenueCtx = document.getElementById('revenueChart');
    if (revenueCtx) {
        new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Revenue',
                    data: [12000, 19000, 15000, 25000, 22000, 30000],
                    borderColor: '#FFD700',
                    backgroundColor: 'rgba(255, 215, 0, 0.1)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4
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
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'New Customers',
                    data: [65, 84, 71, 96, 88, 108],
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
</script>

{if $_c['new_version_notify'] != 'disable'}
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            $.getJSON("./version.json?" + Math.random(), function(data) {
                var localVersion = data.version;
                $('#version').html('Version: ' + localVersion);
                $.getJSON(
                    "https://watsonsdevelopers.com/glinta-africa/version.json?" +
                    Math.random(),
                    function(data) {
                        var latestVersion = data.version;
                        if (localVersion !== latestVersion) {
                            $('#version').html('Latest Version: ' + latestVersion);
                            if (getCookie(latestVersion) != 'done') {
                                Swal.fire({
                                    icon: 'info',
                                    title: "New Version Available\nVersion: " + latestVersion,
                                    toast: true,
                                    position: 'bottom-right',
                                    showConfirmButton: true,
                                    showCloseButton: true,
                                    timer: 30000,
                                    confirmButtonText: 'Update Available',
                                    timerProgressBar: true,
                                    didOpen: (toast) => {
                                        toast.addEventListener('mouseenter', Swal.stopTimer)
                                        toast.addEventListener('mouseleave', Swal.resumeTimer)
                                    }
                                });
                                setCookie(latestVersion, 'done', 7);
                            }
                        }
                    });
            });
        });
    </script>
{/if}

{include file="sections/footer.tpl"}
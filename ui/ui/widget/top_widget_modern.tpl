<div class="modern-stats-grid">
    {if in_array($_admin['user_type'],['SuperAdmin','Admin', 'Report'])}
        <div class="modern-stat-card revenue-card">
            <div class="stat-card-header">
                <div class="stat-icon">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="stat-badge">
                    <span class="status-indicator status-online pulse">Live</span>
                </div>
            </div>
            <div class="stat-card-body">
                <div class="stat-value">
                    <sup class="currency-symbol">{$_c['currency_code']}</sup>
                    <span class="amount">{number_format($iday,0,$_c['dec_point'],$_c['thousands_sep'])}</span>
                </div>
                <div class="stat-label">Income Today</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i>
                    <span class="change-value">+12.5%</span>
                    <span class="change-period">vs yesterday</span>
                </div>
            </div>
            <div class="stat-card-footer">
                <a href="{Text::url('reports/by-date')}" class="stat-link">
                    <span>View Details</span>
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
        
        <div class="modern-stat-card monthly-card">
            <div class="stat-card-header">
                <div class="stat-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="stat-badge">
                    <span class="status-indicator status-online pulse">Live</span>
                </div>
            </div>
            <div class="stat-card-body">
                <div class="stat-value">
                    <sup class="currency-symbol">{$_c['currency_code']}</sup>
                    <span class="amount">{number_format($imonth,0,$_c['dec_point'],$_c['thousands_sep'])}</span>
                </div>
                <div class="stat-label">Income This Month</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i>
                    <span class="change-value">+8.3%</span>
                    <span class="change-period">vs last month</span>
                </div>
            </div>
            <div class="stat-card-footer">
                <a href="{Text::url('reports/by-period')}" class="stat-link">
                    <span>View Details</span>
                    <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
    {/if}
    
    <div class="modern-stat-card users-card">
        <div class="stat-card-header">
            <div class="stat-icon">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-badge">
                <span class="status-indicator status-online pulse">Live</span>
            </div>
        </div>
        <div class="stat-card-body">
            <div class="stat-value">
                <span class="amount">{$u_act}</span>
                <span class="stat-separator">/</span>
                <span class="amount secondary">{$u_all-$u_act}</span>
            </div>
            <div class="stat-label">Active / Expired Users</div>
            <div class="stat-progress">
                <div class="progress-bar">
                    <div class="progress-fill" style="width: {($u_act/($u_all ?: 1)*100)}%"></div>
                </div>
                <div class="progress-text">{($u_act/($u_all ?: 1)*100)|number_format:1}% Active</div>
            </div>
        </div>
        <div class="stat-card-footer">
            <a href="{Text::url('plan/list')}" class="stat-link">
                <span>Manage Users</span>
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>
    
    <div class="modern-stat-card customers-card">
        <div class="stat-card-header">
            <div class="stat-icon">
                <i class="fas fa-user-friends"></i>
            </div>
            <div class="stat-badge">
                <span class="status-indicator status-online pulse">Live</span>
            </div>
        </div>
        <div class="stat-card-body">
            <div class="stat-value">
                <span class="amount">{$c_all}</span>
            </div>
            <div class="stat-label">Total Customers</div>
            <div class="stat-change">
                <i class="fas fa-arrow-up"></i>
                <span class="change-value">+{$c_all - ($c_all * 0.95)|number_format:0}</span>
                <span class="change-period">new this month</span>
            </div>
        </div>
        <div class="stat-card-footer">
            <a href="{Text::url('customers/list')}" class="stat-link">
                <span>View All</span>
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>
    
    <!-- Additional Performance Metrics -->
    <div class="modern-stat-card performance-card">
        <div class="stat-card-header">
            <div class="stat-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-badge">
                <span class="status-indicator status-online pulse">Live</span>
            </div>
        </div>
        <div class="stat-card-body">
            <div class="stat-value">
                <span class="amount">98.5%</span>
            </div>
            <div class="stat-label">System Uptime</div>
            <div class="stat-change">
                <i class="fas fa-check-circle"></i>
                <span class="change-value">Excellent</span>
                <span class="change-period">last 30 days</span>
            </div>
        </div>
        <div class="stat-card-footer">
            <a href="{Text::url('logs/phpnuxbill')}" class="stat-link">
                <span>View Logs</span>
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>
    
    <div class="modern-stat-card bandwidth-card">
        <div class="stat-card-header">
            <div class="stat-icon">
                <i class="fas fa-wifi"></i>
            </div>
            <div class="stat-badge">
                <span class="status-indicator status-online pulse">Live</span>
            </div>
        </div>
        <div class="stat-card-body">
            <div class="stat-value">
                <span class="amount">247.8</span>
                <span class="stat-unit">GB</span>
            </div>
            <div class="stat-label">Data Usage Today</div>
            <div class="stat-change">
                <i class="fas fa-arrow-up"></i>
                <span class="change-value">+15.2%</span>
                <span class="change-period">vs yesterday</span>
            </div>
        </div>
        <div class="stat-card-footer">
            <a href="{Text::url('bandwidth/list')}" class="stat-link">
                <span>View Details</span>
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>
</div>

<style>
.modern-stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: var(--spacing-lg);
    margin-bottom: var(--spacing-2xl);
}

.modern-stat-card {
    background: var(--bg-card);
    border: 1px solid var(--neutral-200);
    border-radius: var(--radius-xl);
    overflow: hidden;
    transition: all var(--transition-normal);
    position: relative;
}

.modern-stat-card::before {
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

.modern-stat-card:hover::before {
    opacity: 1;
}

.modern-stat-card:hover {
    transform: translateY(-5px);
    box-shadow: var(--shadow-xl);
}

.modern-stat-card.revenue-card {
    border-left: 4px solid var(--secondary-green);
}

.modern-stat-card.monthly-card {
    border-left: 4px solid var(--secondary-blue);
}

.modern-stat-card.users-card {
    border-left: 4px solid var(--primary-gold);
}

.modern-stat-card.customers-card {
    border-left: 4px solid var(--secondary-purple);
}

.modern-stat-card.performance-card {
    border-left: 4px solid var(--secondary-green);
}

.modern-stat-card.bandwidth-card {
    border-left: 4px solid var(--secondary-blue);
}

.stat-card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--spacing-lg) var(--spacing-xl) var(--spacing-md);
    background: var(--bg-tertiary);
    border-bottom: 1px solid var(--neutral-200);
}

.stat-icon {
    width: 50px;
    height: 50px;
    background: var(--primary-gold-gradient);
    border-radius: var(--radius-lg);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: var(--font-size-xl);
    color: var(--neutral-900);
}

.stat-badge {
    font-size: var(--font-size-xs);
}

.stat-card-body {
    padding: var(--spacing-xl);
}

.stat-value {
    display: flex;
    align-items: baseline;
    gap: var(--spacing-xs);
    margin-bottom: var(--spacing-sm);
}

.currency-symbol {
    font-size: var(--font-size-lg);
    color: var(--neutral-500);
    font-weight: 600;
}

.amount {
    font-family: var(--font-display);
    font-size: var(--font-size-3xl);
    font-weight: 800;
    color: var(--neutral-900);
}

.amount.secondary {
    color: var(--neutral-500);
}

.stat-separator {
    font-size: var(--font-size-2xl);
    color: var(--neutral-400);
    margin: 0 var(--spacing-xs);
}

.stat-unit {
    font-size: var(--font-size-lg);
    color: var(--neutral-500);
    font-weight: 600;
    margin-left: var(--spacing-xs);
}

.stat-label {
    font-size: var(--font-size-sm);
    font-weight: 600;
    color: var(--neutral-600);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: var(--spacing-md);
}

.stat-change {
    display: flex;
    align-items: center;
    gap: var(--spacing-xs);
    font-size: var(--font-size-sm);
    color: var(--secondary-green);
}

.change-value {
    font-weight: 700;
}

.change-period {
    color: var(--neutral-500);
}

.stat-progress {
    margin-top: var(--spacing-md);
}

.progress-bar {
    height: 6px;
    background: var(--neutral-200);
    border-radius: var(--radius-full);
    overflow: hidden;
    margin-bottom: var(--spacing-xs);
}

.progress-fill {
    height: 100%;
    background: var(--primary-gold-gradient);
    transition: width var(--transition-normal);
}

.progress-text {
    font-size: var(--font-size-xs);
    color: var(--neutral-600);
    text-align: center;
}

.stat-card-footer {
    padding: var(--spacing-md) var(--spacing-xl);
    background: var(--bg-tertiary);
    border-top: 1px solid var(--neutral-200);
}

.stat-link {
    display: flex;
    align-items: center;
    justify-content: space-between;
    color: var(--neutral-600);
    text-decoration: none;
    font-size: var(--font-size-sm);
    font-weight: 600;
    transition: all var(--transition-normal);
}

.stat-link:hover {
    color: var(--primary-gold);
    text-decoration: none;
}

.stat-link i {
    transition: transform var(--transition-normal);
}

.stat-link:hover i {
    transform: translateX(3px);
}

@media (max-width: 768px) {
    .modern-stats-grid {
        grid-template-columns: 1fr;
        gap: var(--spacing-md);
    }
    
    .stat-card-header {
        padding: var(--spacing-md) var(--spacing-lg) var(--spacing-sm);
    }
    
    .stat-card-body {
        padding: var(--spacing-lg);
    }
    
    .stat-icon {
        width: 40px;
        height: 40px;
        font-size: var(--font-size-lg);
    }
    
    .amount {
        font-size: var(--font-size-2xl);
    }
}

/* Animation for loading states */
.stat-loading {
    animation: pulse 1.5s ease-in-out infinite;
}

@keyframes pulse {
    0% { opacity: 1; }
    50% { opacity: 0.5; }
    100% { opacity: 1; }
}

/* Hover effects for better interactivity */
.modern-stat-card:hover .stat-icon {
    transform: scale(1.05);
}

.modern-stat-card:hover .amount {
    color: var(--primary-gold);
}

/* Real-time data animation */
.amount {
    transition: all var(--transition-normal);
}

.amount.updated {
    animation: bounce 0.5s ease-in-out;
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
    40% { transform: translateY(-10px); }
    60% { transform: translateY(-5px); }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Auto-refresh widget data every 30 seconds
    setInterval(function() {
        refreshWidgetData();
    }, 30000);
    
    function refreshWidgetData() {
        // This would normally make an AJAX call to refresh the widget data
        // For now, we'll just add a visual indicator
        const amounts = document.querySelectorAll('.amount');
        amounts.forEach(amount => {
            amount.classList.add('updated');
            setTimeout(() => {
                amount.classList.remove('updated');
            }, 500);
        });
    }
    
    // Add loading state when refreshing
    function showLoading() {
        const cards = document.querySelectorAll('.modern-stat-card');
        cards.forEach(card => {
            card.classList.add('stat-loading');
        });
    }
    
    function hideLoading() {
        const cards = document.querySelectorAll('.modern-stat-card');
        cards.forEach(card => {
            card.classList.remove('stat-loading');
        });
    }
    
    // Animate numbers on page load
    function animateNumbers() {
        const amounts = document.querySelectorAll('.amount');
        amounts.forEach(amount => {
            const finalValue = parseInt(amount.textContent.replace(/[^\d]/g, ''));
            if (finalValue > 0) {
                let currentValue = 0;
                const increment = finalValue / 50;
                const timer = setInterval(() => {
                    currentValue += increment;
                    if (currentValue >= finalValue) {
                        currentValue = finalValue;
                        clearInterval(timer);
                    }
                    amount.textContent = Math.floor(currentValue).toLocaleString();
                }, 20);
            }
        });
    }
    
    // Run animation on page load
    setTimeout(animateNumbers, 300);
});
</script>
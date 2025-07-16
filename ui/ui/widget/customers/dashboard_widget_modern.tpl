<div class="modern-customer-dashboard">
    <!-- Customer Stats Overview -->
    <div class="customer-stats-grid">
        <div class="customer-stat-card active-plan">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-wifi"></i>
                </div>
                <div class="stat-status">
                    <span class="status-indicator status-online pulse">Active</span>
                </div>
            </div>
            <div class="stat-content">
                <div class="stat-value">
                    {if $user_service}
                        <span class="plan-name">{$user_service.plan_name}</span>
                        <span class="plan-type">{$user_service.type}</span>
                    {else}
                        <span class="plan-name">No Active Plan</span>
                        <span class="plan-type">Inactive</span>
                    {/if}
                </div>
                <div class="stat-details">
                    {if $user_service}
                        <div class="detail-item">
                            <i class="fas fa-calendar"></i>
                            <span>Expires: {$user_service.expiration|date_format:"%B %d, %Y"}</span>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Price: {$_c['currency_code']} {$user_service.price}</span>
                        </div>
                    {else}
                        <div class="detail-item">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span>No active internet plan</span>
                        </div>
                    {/if}
                </div>
            </div>
            <div class="stat-footer">
                <a href="{Text::url('order')}" class="btn btn-primary btn-sm">
                    <i class="fas fa-plus"></i>
                    Order Plan
                </a>
            </div>
        </div>
        
        <div class="customer-stat-card balance-card">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-wallet"></i>
                </div>
                <div class="stat-status">
                    <span class="status-indicator {if $user_balance > 0}status-online{else}status-offline{/if}">
                        {if $user_balance > 0}Available{else}Empty{/if}
                    </span>
                </div>
            </div>
            <div class="stat-content">
                <div class="stat-value">
                    <span class="balance-amount">{$_c['currency_code']} {$user_balance|number_format:2}</span>
                    <span class="balance-label">Account Balance</span>
                </div>
                <div class="stat-details">
                    <div class="detail-item">
                        <i class="fas fa-history"></i>
                        <span>Last updated: {$smarty.now|date_format:"%H:%M"}</span>
                    </div>
                </div>
            </div>
            <div class="stat-footer">
                <a href="{Text::url('order/balance')}" class="btn btn-secondary btn-sm">
                    <i class="fas fa-credit-card"></i>
                    Add Balance
                </a>
            </div>
        </div>
        
        <div class="customer-stat-card usage-card">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <div class="stat-status">
                    <span class="status-indicator status-online pulse">Live</span>
                </div>
            </div>
            <div class="stat-content">
                <div class="stat-value">
                    <span class="usage-amount">2.4 GB</span>
                    <span class="usage-label">Today's Usage</span>
                </div>
                <div class="usage-progress">
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 35%"></div>
                    </div>
                    <div class="progress-text">35% of daily limit</div>
                </div>
            </div>
            <div class="stat-footer">
                <a href="{Text::url('dashboard/usage')}" class="btn btn-outline-primary btn-sm">
                    <i class="fas fa-chart-line"></i>
                    View Details
                </a>
            </div>
        </div>
    </div>
    
    <!-- Quick Actions -->
    <div class="quick-actions-section">
        <h3 class="section-title">Quick Actions</h3>
        <div class="quick-actions-grid">
            <div class="quick-action-item">
                <a href="{Text::url('order')}" class="quick-action-link">
                    <div class="action-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="action-content">
                        <h4>Buy Plan</h4>
                        <p>Purchase internet package</p>
                    </div>
                </a>
            </div>
            
            <div class="quick-action-item">
                <a href="{Text::url('order/balance')}" class="quick-action-link">
                    <div class="action-icon">
                        <i class="fas fa-plus-circle"></i>
                    </div>
                    <div class="action-content">
                        <h4>Add Balance</h4>
                        <p>Top up your account</p>
                    </div>
                </a>
            </div>
            
            <div class="quick-action-item">
                <a href="{Text::url('dashboard/history')}" class="quick-action-link">
                    <div class="action-icon">
                        <i class="fas fa-history"></i>
                    </div>
                    <div class="action-content">
                        <h4>History</h4>
                        <p>View transactions</p>
                    </div>
                </a>
            </div>
            
            <div class="quick-action-item">
                <a href="{Text::url('dashboard/support')}" class="quick-action-link">
                    <div class="action-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <div class="action-content">
                        <h4>Support</h4>
                        <p>Get help & support</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
    
    <!-- Recent Activity -->
    <div class="activity-section">
        <h3 class="section-title">Recent Activity</h3>
        <div class="activity-timeline">
            <div class="activity-item">
                <div class="activity-icon success">
                    <i class="fas fa-check"></i>
                </div>
                <div class="activity-content">
                    <h4>Plan Activated</h4>
                    <p>30-day Unlimited package activated successfully</p>
                    <time>2 hours ago</time>
                </div>
            </div>
            
            <div class="activity-item">
                <div class="activity-icon info">
                    <i class="fas fa-credit-card"></i>
                </div>
                <div class="activity-content">
                    <h4>Payment Received</h4>
                    <p>M-Pesa payment of KSh 1,500 processed</p>
                    <time>2 hours ago</time>
                </div>
            </div>
            
            <div class="activity-item">
                <div class="activity-icon warning">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <div class="activity-content">
                    <h4>Usage Alert</h4>
                    <p>You've used 80% of your daily data limit</p>
                    <time>1 day ago</time>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Connection Status -->
    <div class="connection-status">
        <h3 class="section-title">Connection Status</h3>
        <div class="connection-info">
            <div class="connection-item">
                <div class="connection-label">Status</div>
                <div class="connection-value">
                    <span class="status-indicator status-online pulse">Connected</span>
                </div>
            </div>
            
            <div class="connection-item">
                <div class="connection-label">IP Address</div>
                <div class="connection-value">192.168.1.100</div>
            </div>
            
            <div class="connection-item">
                <div class="connection-label">Session Time</div>
                <div class="connection-value">
                    <span id="sessionTime">02:34:15</span>
                </div>
            </div>
            
            <div class="connection-item">
                <div class="connection-label">Data Used</div>
                <div class="connection-value">2.4 GB / 10 GB</div>
            </div>
        </div>
    </div>
</div>

<style>
.modern-customer-dashboard {
    padding: var(--spacing-lg);
    max-width: 1200px;
    margin: 0 auto;
}

.customer-stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: var(--spacing-lg);
    margin-bottom: var(--spacing-2xl);
}

.customer-stat-card {
    background: var(--bg-card);
    border: 1px solid var(--neutral-200);
    border-radius: var(--radius-xl);
    overflow: hidden;
    transition: all var(--transition-normal);
    position: relative;
}

.customer-stat-card::before {
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

.customer-stat-card:hover::before {
    opacity: 1;
}

.customer-stat-card:hover {
    transform: translateY(-3px);
    box-shadow: var(--shadow-lg);
}

.customer-stat-card.active-plan {
    border-left: 4px solid var(--secondary-green);
}

.customer-stat-card.balance-card {
    border-left: 4px solid var(--primary-gold);
}

.customer-stat-card.usage-card {
    border-left: 4px solid var(--secondary-blue);
}

.stat-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--spacing-lg) var(--spacing-xl) var(--spacing-md);
    background: var(--bg-tertiary);
    border-bottom: 1px solid var(--neutral-200);
}

.stat-icon {
    width: 45px;
    height: 45px;
    background: var(--primary-gold-gradient);
    border-radius: var(--radius-lg);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: var(--font-size-lg);
    color: var(--neutral-900);
}

.stat-content {
    padding: var(--spacing-xl);
}

.stat-value {
    margin-bottom: var(--spacing-md);
}

.plan-name {
    display: block;
    font-family: var(--font-display);
    font-size: var(--font-size-xl);
    font-weight: 700;
    color: var(--neutral-900);
    margin-bottom: var(--spacing-xs);
}

.plan-type,
.balance-label,
.usage-label {
    display: block;
    font-size: var(--font-size-sm);
    color: var(--neutral-600);
    font-weight: 500;
}

.balance-amount {
    font-family: var(--font-display);
    font-size: var(--font-size-2xl);
    font-weight: 800;
    color: var(--primary-gold);
    display: block;
    margin-bottom: var(--spacing-xs);
}

.usage-amount {
    font-family: var(--font-display);
    font-size: var(--font-size-2xl);
    font-weight: 800;
    color: var(--secondary-blue);
    display: block;
    margin-bottom: var(--spacing-xs);
}

.stat-details {
    margin-top: var(--spacing-md);
}

.detail-item {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    margin-bottom: var(--spacing-sm);
    font-size: var(--font-size-sm);
    color: var(--neutral-600);
}

.detail-item:last-child {
    margin-bottom: 0;
}

.usage-progress {
    margin-top: var(--spacing-md);
}

.progress-bar {
    height: 8px;
    background: var(--neutral-200);
    border-radius: var(--radius-full);
    overflow: hidden;
    margin-bottom: var(--spacing-xs);
}

.progress-fill {
    height: 100%;
    background: linear-gradient(90deg, var(--secondary-blue) 0%, var(--secondary-blue-light) 100%);
    transition: width var(--transition-normal);
}

.progress-text {
    font-size: var(--font-size-xs);
    color: var(--neutral-600);
    text-align: center;
}

.stat-footer {
    padding: var(--spacing-md) var(--spacing-xl);
    background: var(--bg-tertiary);
    border-top: 1px solid var(--neutral-200);
}

.section-title {
    font-family: var(--font-display);
    font-size: var(--font-size-xl);
    font-weight: 700;
    color: var(--neutral-900);
    margin-bottom: var(--spacing-lg);
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
}

.section-title::before {
    content: '';
    width: 4px;
    height: 24px;
    background: var(--primary-gold-gradient);
    border-radius: var(--radius-sm);
}

.quick-actions-section {
    margin-bottom: var(--spacing-2xl);
}

.quick-actions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: var(--spacing-lg);
}

.quick-action-item {
    background: var(--bg-card);
    border: 1px solid var(--neutral-200);
    border-radius: var(--radius-lg);
    transition: all var(--transition-normal);
    overflow: hidden;
}

.quick-action-item:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-lg);
}

.quick-action-link {
    display: flex;
    align-items: center;
    gap: var(--spacing-md);
    padding: var(--spacing-lg);
    color: inherit;
    text-decoration: none;
}

.quick-action-link:hover {
    color: inherit;
    text-decoration: none;
}

.action-icon {
    width: 50px;
    height: 50px;
    background: var(--primary-gold-gradient);
    border-radius: var(--radius-lg);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: var(--font-size-lg);
    color: var(--neutral-900);
    flex-shrink: 0;
}

.action-content h4 {
    margin: 0 0 var(--spacing-xs) 0;
    font-size: var(--font-size-base);
    font-weight: 600;
    color: var(--neutral-900);
}

.action-content p {
    margin: 0;
    font-size: var(--font-size-sm);
    color: var(--neutral-600);
}

.activity-section {
    margin-bottom: var(--spacing-2xl);
}

.activity-timeline {
    background: var(--bg-card);
    border: 1px solid var(--neutral-200);
    border-radius: var(--radius-lg);
    padding: var(--spacing-lg);
}

.activity-item {
    display: flex;
    gap: var(--spacing-md);
    padding: var(--spacing-md) 0;
    border-bottom: 1px solid var(--neutral-200);
}

.activity-item:last-child {
    border-bottom: none;
}

.activity-icon {
    width: 40px;
    height: 40px;
    border-radius: var(--radius-full);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: var(--font-size-sm);
    color: white;
    flex-shrink: 0;
}

.activity-icon.success {
    background: var(--secondary-green);
}

.activity-icon.info {
    background: var(--secondary-blue);
}

.activity-icon.warning {
    background: #f59e0b;
}

.activity-content h4 {
    margin: 0 0 var(--spacing-xs) 0;
    font-size: var(--font-size-base);
    font-weight: 600;
    color: var(--neutral-900);
}

.activity-content p {
    margin: 0 0 var(--spacing-xs) 0;
    font-size: var(--font-size-sm);
    color: var(--neutral-600);
}

.activity-content time {
    font-size: var(--font-size-xs);
    color: var(--neutral-500);
}

.connection-status {
    background: var(--bg-card);
    border: 1px solid var(--neutral-200);
    border-radius: var(--radius-lg);
    padding: var(--spacing-xl);
}

.connection-info {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: var(--spacing-lg);
}

.connection-item {
    text-align: center;
    padding: var(--spacing-md);
    background: var(--bg-tertiary);
    border-radius: var(--radius-md);
}

.connection-label {
    font-size: var(--font-size-sm);
    color: var(--neutral-600);
    font-weight: 500;
    margin-bottom: var(--spacing-xs);
}

.connection-value {
    font-family: var(--font-display);
    font-size: var(--font-size-lg);
    font-weight: 600;
    color: var(--neutral-900);
}

@media (max-width: 768px) {
    .customer-stats-grid {
        grid-template-columns: 1fr;
    }
    
    .quick-actions-grid {
        grid-template-columns: 1fr;
    }
    
    .connection-info {
        grid-template-columns: 1fr;
    }
    
    .quick-action-link {
        flex-direction: column;
        text-align: center;
    }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Update session time every second
    let sessionSeconds = 9255; // 02:34:15 in seconds
    
    function updateSessionTime() {
        sessionSeconds++;
        const hours = Math.floor(sessionSeconds / 3600);
        const minutes = Math.floor((sessionSeconds % 3600) / 60);
        const seconds = sessionSeconds % 60;
        
        const timeString = 
            hours.toString().padStart(2, '0') + ':' +
            minutes.toString().padStart(2, '0') + ':' +
            seconds.toString().padStart(2, '0');
        
        const sessionTimeElement = document.getElementById('sessionTime');
        if (sessionTimeElement) {
            sessionTimeElement.textContent = timeString;
        }
    }
    
    // Update session time every second
    setInterval(updateSessionTime, 1000);
    
    // Auto-refresh data every 30 seconds
    setInterval(function() {
        // This would normally make an AJAX call to refresh data
        console.log('Refreshing customer dashboard data...');
    }, 30000);
});
</script>
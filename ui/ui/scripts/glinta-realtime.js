/* =====================================================
   GLINTA AFRICA ISP BILLING SYSTEM
   Real-time Dashboard JavaScript
   Created by: Claude AI with Gemini & Context7 Analysis
   ===================================================== */

class GlintaRealTime {
    constructor(options = {}) {
        this.options = {
            refreshInterval: options.refreshInterval || 30000, // 30 seconds
            enableWebSocket: options.enableWebSocket || false,
            enableNotifications: options.enableNotifications || true,
            baseUrl: options.baseUrl || window.location.origin,
            ...options
        };
        
        this.refreshTimer = null;
        this.websocket = null;
        this.isActive = true;
        this.lastUpdate = new Date();
        
        this.init();
    }
    
    init() {
        // Initialize real-time features
        this.setupEventListeners();
        this.startAutoRefresh();
        this.initializeWebSocket();
        this.setupNotifications();
        this.setupSearchSystem();
        this.setupChartUpdates();
        this.setupCounters();
        
        console.log('Glinta Real-time System initialized');
    }
    
    setupEventListeners() {
        // Page visibility API to pause/resume updates
        document.addEventListener('visibilitychange', () => {
            if (document.hidden) {
                this.pauseUpdates();
            } else {
                this.resumeUpdates();
            }
        });
        
        // Window focus/blur events
        window.addEventListener('focus', () => this.resumeUpdates());
        window.addEventListener('blur', () => this.pauseUpdates());
        
        // Manual refresh button
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('refresh-btn')) {
                this.refreshDashboard();
            }
        });
    }
    
    startAutoRefresh() {
        this.refreshTimer = setInterval(() => {
            if (this.isActive) {
                this.refreshDashboard();
            }
        }, this.options.refreshInterval);
    }
    
    pauseUpdates() {
        this.isActive = false;
        if (this.refreshTimer) {
            clearInterval(this.refreshTimer);
        }
    }
    
    resumeUpdates() {
        this.isActive = true;
        this.startAutoRefresh();
        // Immediate refresh when becoming active
        this.refreshDashboard();
    }
    
    async refreshDashboard() {
        try {
            this.showLoadingState();
            
            // Get current user context
            const userType = this.getUserType();
            const resellerId = this.getResellerId();
            
            // Fetch fresh data
            const statsData = await this.fetchDashboardStats(userType, resellerId);
            const networkData = await this.fetchNetworkStatus(resellerId);
            const revenueData = await this.fetchRevenueData(resellerId);
            
            // Update dashboard components
            this.updateStatistics(statsData);
            this.updateNetworkStatus(networkData);
            this.updateRevenueCharts(revenueData);
            this.updateLastRefreshTime();
            
            this.hideLoadingState();
            
            // Show success notification
            if (this.options.enableNotifications) {
                this.showNotification('Dashboard updated successfully', 'success');
            }
            
        } catch (error) {
            console.error('Dashboard refresh failed:', error);
            this.showNotification('Failed to refresh dashboard', 'error');
            this.hideLoadingState();
        }
    }
    
    async fetchDashboardStats(userType, resellerId) {
        const url = userType === 'reseller' 
            ? `${this.options.baseUrl}/api/reseller/dashboard/stats`
            : `${this.options.baseUrl}/api/admin/dashboard/stats`;
            
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({ reseller_id: resellerId })
        });
        
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}`);
        }
        
        return await response.json();
    }
    
    async fetchNetworkStatus(resellerId) {
        const response = await fetch(`${this.options.baseUrl}/api/network/status`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({ reseller_id: resellerId })
        });
        
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}`);
        }
        
        return await response.json();
    }
    
    async fetchRevenueData(resellerId) {
        const response = await fetch(`${this.options.baseUrl}/api/analytics/revenue`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({ 
                reseller_id: resellerId,
                period: 'week'
            })
        });
        
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}`);
        }
        
        return await response.json();
    }
    
    updateStatistics(data) {
        // Update revenue widgets
        this.updateStatWidget('revenue-today', data.revenue_today, 'KES');
        this.updateStatWidget('revenue-month', data.revenue_month, 'KES');
        
        // Update service widgets
        this.updateStatWidget('active-services', data.active_services);
        this.updateStatWidget('expired-services', data.expired_services);
        this.updateStatWidget('total-customers', data.total_customers);
        this.updateStatWidget('total-resellers', data.total_resellers);
        
        // Update progress bars
        this.updateProgressBar('system-health', data.system_health_score);
        
        // Update status indicators
        this.updateStatusIndicators(data);
    }
    
    updateStatWidget(widgetId, value, unit = '') {
        const widget = document.getElementById(widgetId);
        if (!widget) return;
        
        const valueElement = widget.querySelector('.stat-value');
        const changeElement = widget.querySelector('.stat-change');
        
        if (valueElement) {
            // Animate number change
            this.animateNumber(valueElement, value, unit);
        }
        
        if (changeElement && data.changes && data.changes[widgetId]) {
            const change = data.changes[widgetId];
            changeElement.textContent = `${change.percentage}% ${change.direction}`;
            changeElement.className = `stat-change ${change.direction === 'up' ? 'positive' : 'negative'}`;
        }
    }
    
    animateNumber(element, targetValue, unit = '') {
        const currentValue = parseInt(element.textContent.replace(/[^0-9]/g, '')) || 0;
        const duration = 1000; // 1 second
        const startTime = Date.now();
        
        const animate = () => {
            const elapsed = Date.now() - startTime;
            const progress = Math.min(elapsed / duration, 1);
            
            // Easing function
            const easeOutQuart = 1 - Math.pow(1 - progress, 4);
            
            const currentVal = Math.floor(currentValue + (targetValue - currentValue) * easeOutQuart);
            element.textContent = unit ? `${unit} ${currentVal.toLocaleString()}` : currentVal.toLocaleString();
            
            if (progress < 1) {
                requestAnimationFrame(animate);
            }
        };
        
        animate();
    }
    
    updateNetworkStatus(data) {
        const networkContainer = document.querySelector('.network-status');
        if (!networkContainer || !data.routers) return;
        
        // Clear existing content
        networkContainer.innerHTML = '';
        
        // Add router status cards
        data.routers.forEach(router => {
            const routerCard = this.createRouterCard(router);
            networkContainer.appendChild(routerCard);
        });
    }
    
    createRouterCard(router) {
        const card = document.createElement('div');
        card.className = 'router-status';
        
        const statusClass = router.connection_status === 'online' ? 'online' : 
                          router.connection_status === 'warning' ? 'warning' : 'offline';
        
        card.innerHTML = `
            <div class="router-header">
                <h4 class="router-name">${router.router_name}</h4>
                <span class="status-indicator ${statusClass}">${router.connection_status}</span>
            </div>
            <div class="router-ip">${router.ip_address}</div>
            <div class="router-metrics">
                <div class="router-metric">
                    <p class="router-metric-value">${router.active_users}</p>
                    <p class="router-metric-label">Active</p>
                </div>
                <div class="router-metric">
                    <p class="router-metric-value">${router.total_users}</p>
                    <p class="router-metric-label">Total</p>
                </div>
                <div class="router-metric">
                    <p class="router-metric-value">${router.expired_users}</p>
                    <p class="router-metric-label">Expired</p>
                </div>
            </div>
        `;
        
        return card;
    }
    
    updateRevenueCharts(data) {
        // Update Chart.js charts if they exist
        if (window.revenueChart && data.revenue_trend) {
            window.revenueChart.data.labels = data.revenue_trend.labels;
            window.revenueChart.data.datasets[0].data = data.revenue_trend.values;
            window.revenueChart.update();
        }
        
        if (window.customerChart && data.customer_trend) {
            window.customerChart.data.labels = data.customer_trend.labels;
            window.customerChart.data.datasets[0].data = data.customer_trend.values;
            window.customerChart.update();
        }
    }
    
    updateProgressBar(barId, percentage) {
        const progressBar = document.getElementById(barId);
        if (!progressBar) return;
        
        const progressFill = progressBar.querySelector('.progress-fill');
        if (progressFill) {
            progressFill.style.width = `${percentage}%`;
        }
    }
    
    updateStatusIndicators(data) {
        // Update real-time indicators
        const indicators = document.querySelectorAll('.real-time-indicator');
        indicators.forEach(indicator => {
            if (data.system_online) {
                indicator.style.backgroundColor = 'var(--success-green)';
            } else {
                indicator.style.backgroundColor = 'var(--danger-red)';
            }
        });
    }
    
    updateLastRefreshTime() {
        this.lastUpdate = new Date();
        const timeElements = document.querySelectorAll('.last-update-time');
        timeElements.forEach(element => {
            element.textContent = this.formatTime(this.lastUpdate);
        });
    }
    
    showLoadingState() {
        // Show loading spinners
        const loadingElements = document.querySelectorAll('.loading-spinner');
        loadingElements.forEach(element => {
            element.style.display = 'inline-block';
        });
        
        // Add skeleton loading to stat widgets
        const statWidgets = document.querySelectorAll('.stat-widget');
        statWidgets.forEach(widget => {
            widget.classList.add('loading');
        });
    }
    
    hideLoadingState() {
        // Hide loading spinners
        const loadingElements = document.querySelectorAll('.loading-spinner');
        loadingElements.forEach(element => {
            element.style.display = 'none';
        });
        
        // Remove skeleton loading
        const statWidgets = document.querySelectorAll('.stat-widget');
        statWidgets.forEach(widget => {
            widget.classList.remove('loading');
        });
    }
    
    initializeWebSocket() {
        if (!this.options.enableWebSocket) return;
        
        const wsUrl = `ws://${window.location.host}/ws/dashboard`;
        this.websocket = new WebSocket(wsUrl);
        
        this.websocket.onopen = () => {
            console.log('WebSocket connected');
        };
        
        this.websocket.onmessage = (event) => {
            const data = JSON.parse(event.data);
            this.handleWebSocketMessage(data);
        };
        
        this.websocket.onclose = () => {
            console.log('WebSocket disconnected');
            // Attempt to reconnect after 5 seconds
            setTimeout(() => this.initializeWebSocket(), 5000);
        };
        
        this.websocket.onerror = (error) => {
            console.error('WebSocket error:', error);
        };
    }
    
    handleWebSocketMessage(data) {
        switch (data.type) {
            case 'stats_update':
                this.updateStatistics(data.payload);
                break;
            case 'network_update':
                this.updateNetworkStatus(data.payload);
                break;
            case 'notification':
                this.showNotification(data.payload.message, data.payload.type);
                break;
            case 'system_alert':
                this.showSystemAlert(data.payload);
                break;
        }
    }
    
    setupNotifications() {
        if (!this.options.enableNotifications) return;
        
        // Create notification container
        const container = document.createElement('div');
        container.id = 'notification-container';
        container.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            max-width: 400px;
        `;
        document.body.appendChild(container);
    }
    
    showNotification(message, type = 'info', duration = 5000) {
        const container = document.getElementById('notification-container');
        if (!container) return;
        
        const notification = document.createElement('div');
        notification.className = `notification ${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <p>${message}</p>
                <button class="notification-close">&times;</button>
            </div>
        `;
        
        container.appendChild(notification);
        
        // Show notification
        setTimeout(() => notification.classList.add('show'), 100);
        
        // Auto-hide after duration
        setTimeout(() => {
            notification.classList.remove('show');
            setTimeout(() => container.removeChild(notification), 300);
        }, duration);
        
        // Close button
        notification.querySelector('.notification-close').addEventListener('click', () => {
            notification.classList.remove('show');
            setTimeout(() => container.removeChild(notification), 300);
        });
    }
    
    showSystemAlert(data) {
        // Show important system alerts
        const alertHtml = `
            <div class="system-alert alert-${data.severity}">
                <h4>${data.title}</h4>
                <p>${data.message}</p>
                <div class="alert-actions">
                    <button class="btn-primary" onclick="handleAlertAction('${data.action}')">
                        ${data.action_label}
                    </button>
                </div>
            </div>
        `;
        
        const alertContainer = document.getElementById('system-alerts');
        if (alertContainer) {
            alertContainer.innerHTML = alertHtml;
        }
    }
    
    setupSearchSystem() {
        const searchInputs = document.querySelectorAll('.search-input');
        searchInputs.forEach(input => {
            let searchTimeout;
            
            input.addEventListener('input', (e) => {
                clearTimeout(searchTimeout);
                searchTimeout = setTimeout(() => {
                    this.performSearch(e.target.value);
                }, 300);
            });
        });
    }
    
    async performSearch(query) {
        if (query.length < 2) return;
        
        try {
            const response = await fetch(`${this.options.baseUrl}/api/search`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: JSON.stringify({ query })
            });
            
            const results = await response.json();
            this.displaySearchResults(results);
            
        } catch (error) {
            console.error('Search failed:', error);
        }
    }
    
    displaySearchResults(results) {
        const resultsContainer = document.getElementById('search-results');
        if (!resultsContainer) return;
        
        resultsContainer.innerHTML = '';
        
        if (results.length === 0) {
            resultsContainer.innerHTML = '<p>No results found</p>';
            return;
        }
        
        results.forEach(result => {
            const resultElement = document.createElement('div');
            resultElement.className = 'search-result';
            resultElement.innerHTML = `
                <h5>${result.title}</h5>
                <p>${result.description}</p>
                <a href="${result.url}" class="btn-secondary btn-sm">View</a>
            `;
            resultsContainer.appendChild(resultElement);
        });
    }
    
    setupChartUpdates() {
        // Initialize charts if Chart.js is available
        if (typeof Chart !== 'undefined') {
            this.initializeCharts();
        }
    }
    
    initializeCharts() {
        // Revenue chart
        const revenueCanvas = document.getElementById('revenue-chart');
        if (revenueCanvas) {
            window.revenueChart = new Chart(revenueCanvas, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [{
                        label: 'Revenue',
                        data: [],
                        borderColor: 'var(--primary-gold)',
                        backgroundColor: 'rgba(255, 215, 0, 0.1)',
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
                                    return 'KES ' + value.toLocaleString();
                                }
                            }
                        }
                    }
                }
            });
        }
        
        // Customer growth chart
        const customerCanvas = document.getElementById('customer-chart');
        if (customerCanvas) {
            window.customerChart = new Chart(customerCanvas, {
                type: 'bar',
                data: {
                    labels: [],
                    datasets: [{
                        label: 'New Customers',
                        data: [],
                        backgroundColor: 'var(--accent-blue)',
                        borderRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }
    }
    
    setupCounters() {
        // Setup animated counters for statistics
        const counters = document.querySelectorAll('.stat-value');
        counters.forEach(counter => {
            const target = parseInt(counter.textContent.replace(/[^0-9]/g, ''));
            this.animateNumber(counter, target);
        });
    }
    
    // Utility methods
    getUserType() {
        return document.body.dataset.userType || 'admin';
    }
    
    getResellerId() {
        return document.body.dataset.resellerId || null;
    }
    
    formatTime(date) {
        return date.toLocaleTimeString();
    }
    
    formatCurrency(amount) {
        return new Intl.NumberFormat('en-KE', {
            style: 'currency',
            currency: 'KES'
        }).format(amount);
    }
    
    // Public API methods
    refresh() {
        this.refreshDashboard();
    }
    
    pause() {
        this.pauseUpdates();
    }
    
    resume() {
        this.resumeUpdates();
    }
    
    destroy() {
        this.pauseUpdates();
        if (this.websocket) {
            this.websocket.close();
        }
    }
}

// Global functions for backward compatibility
window.handleAlertAction = function(action) {
    console.log('Alert action:', action);
};

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    // Auto-initialize if config is available
    if (window.glintaConfig) {
        window.glintaRealTime = new GlintaRealTime(window.glintaConfig);
    }
});

// Export for module usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = GlintaRealTime;
}

// Global access
window.GlintaRealTime = GlintaRealTime;
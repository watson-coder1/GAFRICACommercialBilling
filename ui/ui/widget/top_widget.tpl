<div class="stats-grid">
    {if in_array($_admin['user_type'],['SuperAdmin','Admin', 'Report'])}
        <div class="stat-widget revenue-card" id="revenue-today">
            <div class="stat-header">
                <h4 class="stat-title">{Lang::T('Income Today')}</h4>
                <div class="stat-icon">
                    <i class="ion ion-clock"></i>
                </div>
            </div>
            <div class="stat-value">
                <sup>{$_c['currency_code']}</sup>
                <span class="amount">{number_format($iday,0,$_c['dec_point'],$_c['thousands_sep'])}</span>
            </div>
            <div class="stat-change neutral">
                <i class="fa fa-chart-line"></i>
                <span>Daily Revenue</span>
            </div>
            <a href="{Text::url('reports/by-date')}" class="stat-link"></a>
        </div>
        <div class="stat-widget revenue-card" id="revenue-month">
            <div class="stat-header">
                <h4 class="stat-title">{Lang::T('Income This Month')}</h4>
                <div class="stat-icon">
                    <i class="ion ion-android-calendar"></i>
                </div>
            </div>
            <div class="stat-value">
                <sup>{$_c['currency_code']}</sup>
                <span class="amount">{number_format($imonth,0,$_c['dec_point'],$_c['thousands_sep'])}</span>
            </div>
            <div class="stat-change neutral">
                <i class="fa fa-chart-bar"></i>
                <span>Monthly Revenue</span>
            </div>
            <a href="{Text::url('reports/by-period')}" class="stat-link"></a>
        </div>
    {/if}
    <div class="stat-widget service-card" id="active-services">
        <div class="stat-header">
            <h4 class="stat-title">{Lang::T('Active')}/{Lang::T('Expired')}</h4>
            <div class="stat-icon">
                <i class="ion ion-person"></i>
            </div>
        </div>
        <div class="stat-value">
            <span class="amount">{$u_act}/{$u_all-$u_act}</span>
        </div>
        <div class="stat-change neutral">
            <i class="fa fa-users"></i>
            <span>Service Status</span>
        </div>
        <a href="{Text::url('plan/list')}" class="stat-link"></a>
    </div>
    <div class="stat-widget customer-card" id="total-customers">
        <div class="stat-header">
            <h4 class="stat-title">{Lang::T('Customers')}</h4>
            <div class="stat-icon">
                <i class="ion ion-android-people"></i>
            </div>
        </div>
        <div class="stat-value">
            <span class="amount">{$c_all}</span>
        </div>
        <div class="stat-change neutral">
            <i class="fa fa-user-plus"></i>
            <span>Total Customers</span>
        </div>
        <a href="{Text::url('customers/list')}" class="stat-link"></a>
    </div>
</div>
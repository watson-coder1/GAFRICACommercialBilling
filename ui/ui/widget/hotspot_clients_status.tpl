<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">
            <i class="fa fa-wifi"></i> Hotspot Clients Status
        </h3>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-6">
                <div class="metric-box text-center" style="padding: 10px; margin-bottom: 10px; border-radius: 5px; background: #28a745; color: white;">
                    <div class="metric-number" style="font-size: 24px; font-weight: bold;">{$hotspot_online}</div>
                    <div class="metric-label">Currently Online</div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="metric-box text-center" style="padding: 10px; margin-bottom: 10px; border-radius: 5px; background: #17a2b8; color: white;">
                    <div class="metric-number" style="font-size: 24px; font-weight: bold;">{$hotspot_active}</div>
                    <div class="metric-label">Active Plans</div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <div class="metric-box text-center" style="padding: 10px; margin-bottom: 10px; border-radius: 5px; background: #ffc107; color: white;">
                    <div class="metric-number" style="font-size: 24px; font-weight: bold;">{$hotspot_expired}</div>
                    <div class="metric-label">Expired Plans</div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="metric-box text-center" style="padding: 10px; margin-bottom: 10px; border-radius: 5px; background: #6c757d; color: white;">
                    <div class="metric-number" style="font-size: 24px; font-weight: bold;">{$hotspot_logged_out}</div>
                    <div class="metric-label">Logged Out</div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <div class="metric-box text-center" style="padding: 10px; margin-bottom: 10px; border-radius: 5px; background: #dc3545; color: white;">
                    <div class="metric-number" style="font-size: 24px; font-weight: bold;">{$hotspot_disabled}</div>
                    <div class="metric-label">Disabled</div>
                </div>
            </div>
        </div>
        
        <hr style="margin: 15px 0;">
        
        <div class="row">
            <div class="col-md-6">
                <div class="text-center">
                    <strong>Total Customers</strong><br>
                    <span class="text-primary" style="font-size: 18px;">{$hotspot_total}</span>
                </div>
            </div>
            <div class="col-md-6">
                <div class="text-center">
                    <strong>Transactions Today</strong><br>
                    <span class="text-success" style="font-size: 18px;">{$hotspot_transactions_today}</span>
                </div>
            </div>
        </div>
    </div>
</div>
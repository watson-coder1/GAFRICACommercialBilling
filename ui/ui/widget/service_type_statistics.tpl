<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title">
            <i class="fa fa-pie-chart"></i> Service Type Statistics
        </h3>
    </div>
    <div class="panel-body">
        <!-- Customer Distribution -->
        <div class="row">
            <div class="col-md-12">
                <h4 class="text-center" style="margin-bottom: 20px;">Customer Distribution</h4>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-4">
                <div class="text-center" style="padding: 15px; background: #f8f9fa; border-radius: 5px; margin-bottom: 15px;">
                    <div class="service-icon" style="font-size: 30px; color: #007bff; margin-bottom: 10px;">
                        <i class="fa fa-desktop"></i>
                    </div>
                    <div class="service-stats">
                        <div style="font-size: 24px; font-weight: bold; color: #007bff;">{$pppoe_customers}</div>
                        <div style="font-size: 12px; color: #6c757d;">PPPoE Customers</div>
                        <div style="font-size: 14px; color: #007bff;">{$pppoe_customer_percent}%</div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="text-center" style="padding: 15px; background: #f8f9fa; border-radius: 5px; margin-bottom: 15px;">
                    <div class="service-icon" style="font-size: 30px; color: #28a745; margin-bottom: 10px;">
                        <i class="fa fa-wifi"></i>
                    </div>
                    <div class="service-stats">
                        <div style="font-size: 24px; font-weight: bold; color: #28a745;">{$hotspot_customers}</div>
                        <div style="font-size: 12px; color: #6c757d;">Hotspot Customers</div>
                        <div style="font-size: 14px; color: #28a745;">{$hotspot_customer_percent}%</div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="text-center" style="padding: 15px; background: #e9ecef; border-radius: 5px; margin-bottom: 15px;">
                    <div class="service-icon" style="font-size: 30px; color: #6c757d; margin-bottom: 10px;">
                        <i class="fa fa-users"></i>
                    </div>
                    <div class="service-stats">
                        <div style="font-size: 24px; font-weight: bold; color: #6c757d;">{$total_customers}</div>
                        <div style="font-size: 12px; color: #6c757d;">Total Customers</div>
                        <div style="font-size: 14px; color: #6c757d;">100%</div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Revenue Comparison -->
        <div class="row">
            <div class="col-md-12">
                <h4 class="text-center" style="margin: 20px 0;">Revenue Comparison</h4>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading text-center" style="background: #007bff; color: white;">
                        <strong>PPPoE Revenue</strong>
                    </div>
                    <div class="panel-body text-center">
                        <div style="margin-bottom: 10px;">
                            <strong>Today:</strong> KSh {$pppoe_revenue_today}
                        </div>
                        <div style="margin-bottom: 10px;">
                            <strong>This Month:</strong> KSh {$pppoe_revenue_month}
                        </div>
                        <div style="font-size: 18px; color: #007bff;">
                            <strong>{$pppoe_revenue_percent}%</strong> of total
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading text-center" style="background: #28a745; color: white;">
                        <strong>Hotspot Revenue</strong>
                    </div>
                    <div class="panel-body text-center">
                        <div style="margin-bottom: 10px;">
                            <strong>Today:</strong> KSh {$hotspot_revenue_today}
                        </div>
                        <div style="margin-bottom: 10px;">
                            <strong>This Month:</strong> KSh {$hotspot_revenue_month}
                        </div>
                        <div style="font-size: 18px; color: #28a745;">
                            <strong>{$hotspot_revenue_percent}%</strong> of total
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Active Plans -->
        <div class="row">
            <div class="col-md-12">
                <div class="text-center" style="padding: 10px; background: #f8f9fa; border-radius: 5px;">
                    <div style="margin-bottom: 5px;">
                        <strong>Active Plans:</strong> 
                        <span style="color: #007bff;">{$pppoe_active_plans} PPPoE</span> + 
                        <span style="color: #28a745;">{$hotspot_active_plans} Hotspot</span> = 
                        <span style="color: #6c757d;">{$total_active_plans} Total</span>
                    </div>
                    <div style="font-size: 14px; color: #6c757d;">
                        <strong>Total Monthly Revenue:</strong> KSh {$total_revenue_month}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
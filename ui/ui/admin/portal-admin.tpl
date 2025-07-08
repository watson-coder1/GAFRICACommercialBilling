{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-primary panel-hovered">
            <div class="panel-heading">
                <h3 class="panel-title">Portal Management</h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-blue"><i class="fa fa-wifi"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Active Sessions</span>
                                <span class="info-box-number">
                                    {$sessions|@count}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-green"><i class="fa fa-credit-card"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Completed Payments</span>
                                <span class="info-box-number">
                                    {assign var=completed value=0}
                                    {foreach $sessions as $session}
                                        {if $session->payment_status == 'completed'}
                                            {assign var=completed value=$completed+1}
                                        {/if}
                                    {/foreach}
                                    {$completed}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-yellow"><i class="fa fa-clock-o"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Pending Payments</span>
                                <span class="info-box-number">
                                    {assign var=pending value=0}
                                    {foreach $sessions as $session}
                                        {if $session->payment_status == 'pending'}
                                            {assign var=pending value=$pending+1}
                                        {/if}
                                    {/foreach}
                                    {$pending}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="info-box">
                            <span class="info-box-icon bg-gold"><i class="fa fa-money"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Total Revenue</span>
                                <span class="info-box-number">
                                    KSh {assign var=revenue value=0}
                                    {foreach $sessions as $session}
                                        {if $session->payment_status == 'completed'}
                                            {assign var=revenue value=$revenue+$session->price}
                                        {/if}
                                    {/foreach}
                                    {$revenue}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Recent Portal Sessions</h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Session ID</th>
                                <th>Package</th>
                                <th>Phone</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Expires</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $sessions as $session}
                            <tr>
                                <td>{$session->session_id|substr:0:12}...</td>
                                <td>{$session->name}</td>
                                <td>{$session->phone_number}</td>
                                <td>KSh {$session->price}</td>
                                <td>
                                    {if $session->payment_status == 'completed'}
                                        <span class="label label-success">Completed</span>
                                    {elseif $session->payment_status == 'pending'}
                                        <span class="label label-warning">Pending</span>
                                    {else}
                                        <span class="label label-danger">Failed</span>
                                    {/if}
                                </td>
                                <td>{$session->created_at|date_format:"%Y-%m-%d %H:%M"}</td>
                                <td>
                                    {if $session->expires_at}
                                        {$session->expires_at|date_format:"%Y-%m-%d %H:%M"}
                                    {else}
                                        -
                                    {/if}
                                </td>
                                <td>
                                    <a href="{$app_url}/?_route=portal/status/{$session->session_id}" 
                                       class="btn btn-sm btn-primary" target="_blank">
                                        <i class="fa fa-eye"></i> View
                                    </a>
                                </td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Available Packages</h3>
            </div>
            <div class="panel-body">
                {foreach $packages as $package}
                <div class="package-card" style="border: 1px solid #ddd; border-radius: 8px; padding: 15px; margin-bottom: 15px;">
                    <h4 style="margin-top: 0; color: #333;">{$package->name}</h4>
                    <div style="font-size: 20px; font-weight: bold; color: #FFD700; margin-bottom: 10px;">
                        KSh {$package->price}
                    </div>
                    <div style="color: #666; margin-bottom: 10px;">
                        {$package->duration_hours} hours
                        {if $package->data_limit_mb}
                            • {($package->data_limit_mb/1024)|number_format:1}GB
                        {/if}
                    </div>
                    <div style="color: #888; font-size: 12px;">
                        {$package->description}
                    </div>
                    <div style="margin-top: 10px;">
                        <span class="label {if $package->status == 'active'}label-success{else}label-default{/if}">
                            {$package->status|ucfirst}
                        </span>
                    </div>
                </div>
                {/foreach}
                
                <div style="margin-top: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px;">
                    <h5 style="color: #666; margin-bottom: 10px;">📱 M-Pesa Configuration</h5>
                    <p style="color: #666; font-size: 12px; margin-bottom: 5px;">
                        To enable M-Pesa payments, configure the following in Settings:
                    </p>
                    <ul style="color: #666; font-size: 12px; margin-bottom: 0;">
                        <li>mpesa_consumer_key</li>
                        <li>mpesa_consumer_secret</li>
                        <li>mpesa_passkey</li>
                        <li>mpesa_shortcode</li>
                        <li>mpesa_environment (sandbox/live)</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Portal Access Links</h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Customer Portal</h5>
                        <div class="input-group">
                            <input type="text" class="form-control" 
                                   value="{$app_url}/?_route=portal/login" readonly>
                            <div class="input-group-btn">
                                <button class="btn btn-primary" onclick="copyToClipboard(this.previousElementSibling)">
                                    <i class="fa fa-copy"></i> Copy
                                </button>
                            </div>
                        </div>
                        <small class="text-muted">
                            This is the main portal URL customers will be redirected to
                        </small>
                    </div>
                    <div class="col-md-6">
                        <h5>MikroTik Hotspot Configuration</h5>
                        <div class="alert alert-info">
                            <strong>Walled Garden:</strong><br>
                            Add your domain to MikroTik walled garden:<br>
                            <code>/ip hotspot walled-garden add dst-host=yourdomain.com</code>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function copyToClipboard(element) {
    element.select();
    document.execCommand('copy');
    
    // Show success message
    const btn = element.nextElementSibling;
    const originalText = btn.innerHTML;
    btn.innerHTML = '<i class="fa fa-check"></i> Copied!';
    btn.classList.add('btn-success');
    btn.classList.remove('btn-primary');
    
    setTimeout(() => {
        btn.innerHTML = originalText;
        btn.classList.remove('btn-success');
        btn.classList.add('btn-primary');
    }, 2000);
}
</script>

{include file="sections/footer.tpl"}
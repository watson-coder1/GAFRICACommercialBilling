{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-primary panel-hovered">
            <div class="panel-heading">
                <h3 class="panel-title">Hotspot Packages Management</h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-6">
                        <a href="{$app_url}/?_route=packages/add" class="btn btn-primary">
                            <i class="fa fa-plus"></i> Add New Package
                        </a>
                    </div>
                    <div class="col-md-6 text-right">
                        <a href="{$app_url}/?_route=portal/admin" class="btn btn-info">
                            <i class="fa fa-wifi"></i> Portal Management
                        </a>
                    </div>
                </div>
                
                <div class="table-responsive" style="margin-top: 20px;">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Package Name</th>
                                <th>Price (KSh)</th>
                                <th>Duration</th>
                                <th>Data Limit</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $packages as $package}
                            <tr>
                                <td>
                                    <strong>{$package->name}</strong>
                                </td>
                                <td>
                                    <span style="color: #FFD700; font-weight: bold;">
                                        KSh {$package->price}
                                    </span>
                                </td>
                                <td>
                                    {if $package->duration_hours < 24}
                                        {$package->duration_hours} hours
                                    {else}
                                        {($package->duration_hours/24)|number_format:0} days
                                    {/if}
                                </td>
                                <td>
                                    {if $package->data_limit_mb}
                                        {if $package->data_limit_mb < 1024}
                                            {$package->data_limit_mb}MB
                                        {else}
                                            {($package->data_limit_mb/1024)|number_format:1}GB
                                        {/if}
                                    {else}
                                        <span class="text-muted">Unlimited</span>
                                    {/if}
                                </td>
                                <td>
                                    <small>{$package->description}</small>
                                </td>
                                <td>
                                    {if $package->status == 'active'}
                                        <span class="label label-success">Active</span>
                                    {else}
                                        <span class="label label-default">Inactive</span>
                                    {/if}
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <a href="{$app_url}/?_route=packages/edit/{$package->id}" 
                                           class="btn btn-sm btn-warning">
                                            <i class="fa fa-edit"></i> Edit
                                        </a>
                                        <a href="{$app_url}/?_route=packages/toggle/{$package->id}" 
                                           class="btn btn-sm {if $package->status == 'active'}btn-default{else}btn-success{/if}"
                                           onclick="return confirm('Toggle package status?')">
                                            <i class="fa fa-{if $package->status == 'active'}pause{else}play{/if}"></i>
                                            {if $package->status == 'active'}Disable{else}Enable{/if}
                                        </a>
                                        <a href="{$app_url}/?_route=packages/delete/{$package->id}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Are you sure you want to delete this package?')">
                                            <i class="fa fa-trash"></i> Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                
                {if !$packages}
                <div class="text-center" style="padding: 40px;">
                    <i class="fa fa-wifi" style="font-size: 48px; color: #ccc;"></i>
                    <h4>No packages found</h4>
                    <p>Create your first hotspot package to get started.</p>
                    <a href="{$app_url}/?_route=packages/add" class="btn btn-primary">
                        <i class="fa fa-plus"></i> Add New Package
                    </a>
                </div>
                {/if}
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Package Guidelines</h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-6">
                        <h5>💡 Package Naming Tips:</h5>
                        <ul>
                            <li><strong>Quick Browse</strong> - For short sessions (1-2 hours)</li>
                            <li><strong>Half Day</strong> - For medium sessions (3-6 hours)</li>
                            <li><strong>Full Day</strong> - For full day access (12-24 hours)</li>
                            <li><strong>Weekend</strong> - For extended access (2-3 days)</li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h5>💰 Pricing Strategy:</h5>
                        <ul>
                            <li><strong>KSh 10-20</strong> - Basic browsing packages</li>
                            <li><strong>KSh 30-50</strong> - Standard packages</li>
                            <li><strong>KSh 70-100</strong> - Premium packages</li>
                            <li><strong>KSh 150+</strong> - Extended access packages</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="sections/footer.tpl"}
{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-8">
        <div class="panel panel-primary panel-hovered">
            <div class="panel-heading">
                <h3 class="panel-title">Edit Package: {$package->name}</h3>
            </div>
            <div class="panel-body">
                <form method="post" action="{$app_url}/?_route=packages/edit/{$package->id}/post">
                    <div class="form-group">
                        <label for="name">Package Name *</label>
                        <input type="text" class="form-control" id="name" name="name" 
                               value="{$package->name}" required>
                        <small class="form-text text-muted">
                            Choose a descriptive name that customers will easily understand
                        </small>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="price">Price (KSh) *</label>
                                <input type="number" class="form-control" id="price" name="price" 
                                       min="1" step="0.01" value="{$package->price}" required>
                                <small class="form-text text-muted">
                                    Price in Kenyan Shillings
                                </small>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="duration_hours">Duration (Hours) *</label>
                                <input type="number" class="form-control" id="duration_hours" name="duration_hours" 
                                       min="1" value="{$package->duration_hours}" required>
                                <small class="form-text text-muted">
                                    Access duration in hours (24 = 1 day, 72 = 3 days)
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="data_limit_mb">Data Limit (MB)</label>
                        <input type="number" class="form-control" id="data_limit_mb" name="data_limit_mb" 
                               min="1" value="{$package->data_limit_mb}">
                        <small class="form-text text-muted">
                            Optional: Data limit in MB (1024 MB = 1 GB). Leave empty for unlimited data
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3">{$package->description}</textarea>
                        <small class="form-text text-muted">
                            Describe what the package includes - this will be shown to customers
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select class="form-control" id="status" name="status">
                            <option value="active" {if $package->status == 'active'}selected{/if}>Active</option>
                            <option value="inactive" {if $package->status == 'inactive'}selected{/if}>Inactive</option>
                        </select>
                        <small class="form-text text-muted">
                            Only active packages will be shown to customers
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-save"></i> Update Package
                        </button>
                        <a href="{$app_url}/?_route=packages/list" class="btn btn-default">
                            <i class="fa fa-arrow-left"></i> Back to List
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Package Statistics</h3>
            </div>
            <div class="panel-body">
                <div class="info-item">
                    <i class="fa fa-clock-o"></i>
                    <strong>Duration:</strong> 
                    {if $package->duration_hours < 24}
                        {$package->duration_hours} hours
                    {else}
                        {($package->duration_hours/24)|number_format:0} days
                    {/if}
                </div>
                
                <div class="info-item">
                    <i class="fa fa-database"></i>
                    <strong>Data Limit:</strong>
                    {if $package->data_limit_mb}
                        {if $package->data_limit_mb < 1024}
                            {$package->data_limit_mb}MB
                        {else}
                            {($package->data_limit_mb/1024)|number_format:1}GB
                        {/if}
                    {else}
                        Unlimited
                    {/if}
                </div>
                
                <div class="info-item">
                    <i class="fa fa-money"></i>
                    <strong>Price per Hour:</strong>
                    KSh {($package->price/$package->duration_hours)|number_format:2}
                </div>
                
                <div class="info-item">
                    <i class="fa fa-users"></i>
                    <strong>Usage Count:</strong>
                    {assign var="usage_count" value=0}
                    {* This would be calculated from tbl_portal_sessions *}
                    {$usage_count} times
                </div>
                
                <div class="info-item">
                    <i class="fa fa-calendar"></i>
                    <strong>Created:</strong>
                    {$package->created_at|date_format:"%Y-%m-%d %H:%M"}
                </div>
                
                <div class="info-item">
                    <i class="fa fa-edit"></i>
                    <strong>Updated:</strong>
                    {$package->updated_at|date_format:"%Y-%m-%d %H:%M"}
                </div>
            </div>
        </div>
        
        <div class="panel panel-warning">
            <div class="panel-heading">
                <h3 class="panel-title">⚠️ Important Notes</h3>
            </div>
            <div class="panel-body">
                <ul>
                    <li>Changing price affects new purchases only</li>
                    <li>Duration changes don't affect active sessions</li>
                    <li>Disabling a package hides it from customers</li>
                    <li>Cannot delete packages that have been used</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<style>
.info-item {
    margin-bottom: 15px;
    padding: 10px;
    background: #f8f9fa;
    border-radius: 5px;
}
.info-item i {
    color: #FFD700;
    margin-right: 10px;
    width: 20px;
}
</style>

{include file="sections/footer.tpl"}
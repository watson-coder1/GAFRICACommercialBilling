{include file="sections/header.tpl"}

<div class="row">
    <div class="col-md-8">
        <div class="panel panel-primary panel-hovered">
            <div class="panel-heading">
                <h3 class="panel-title">Add New Hotspot Package</h3>
            </div>
            <div class="panel-body">
                <form method="post" action="{$app_url}/?_route=packages/add/post">
                    <div class="form-group">
                        <label for="name">Package Name *</label>
                        <input type="text" class="form-control" id="name" name="name" 
                               placeholder="e.g., Quick Browse, Half Day, Full Day" required>
                        <small class="form-text text-muted">
                            Choose a descriptive name that customers will easily understand
                        </small>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="price">Price (KSh) *</label>
                                <input type="number" class="form-control" id="price" name="price" 
                                       min="1" step="0.01" placeholder="e.g., 10.00" required>
                                <small class="form-text text-muted">
                                    Price in Kenyan Shillings
                                </small>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="duration_hours">Duration (Hours) *</label>
                                <input type="number" class="form-control" id="duration_hours" name="duration_hours" 
                                       min="1" placeholder="e.g., 2, 24, 72" required>
                                <small class="form-text text-muted">
                                    Access duration in hours (24 = 1 day, 72 = 3 days)
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="data_limit_mb">Data Limit (MB)</label>
                        <input type="number" class="form-control" id="data_limit_mb" name="data_limit_mb" 
                               min="1" placeholder="e.g., 500, 1024, 3072">
                        <small class="form-text text-muted">
                            Optional: Data limit in MB (1024 MB = 1 GB). Leave empty for unlimited data
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" 
                                  placeholder="e.g., 2 hours internet access with 500MB data"></textarea>
                        <small class="form-text text-muted">
                            Describe what the package includes - this will be shown to customers
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-save"></i> Create Package
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
                <h3 class="panel-title">Package Examples</h3>
            </div>
            <div class="panel-body">
                <div class="example-package">
                    <h5>📱 Quick Browse</h5>
                    <ul>
                        <li><strong>Price:</strong> KSh 10</li>
                        <li><strong>Duration:</strong> 2 hours</li>
                        <li><strong>Data:</strong> 500MB</li>
                        <li><strong>Use:</strong> Quick browsing, social media</li>
                    </ul>
                </div>
                
                <div class="example-package">
                    <h5>🌐 Half Day</h5>
                    <ul>
                        <li><strong>Price:</strong> KSh 20</li>
                        <li><strong>Duration:</strong> 4 hours</li>
                        <li><strong>Data:</strong> 1GB</li>
                        <li><strong>Use:</strong> Work, video calls</li>
                    </ul>
                </div>
                
                <div class="example-package">
                    <h5>🎯 Full Day</h5>
                    <ul>
                        <li><strong>Price:</strong> KSh 50</li>
                        <li><strong>Duration:</strong> 24 hours</li>
                        <li><strong>Data:</strong> 3GB</li>
                        <li><strong>Use:</strong> Full day access</li>
                    </ul>
                </div>
                
                <div class="example-package">
                    <h5>🏖️ Weekend</h5>
                    <ul>
                        <li><strong>Price:</strong> KSh 100</li>
                        <li><strong>Duration:</strong> 72 hours</li>
                        <li><strong>Data:</strong> 5GB</li>
                        <li><strong>Use:</strong> Extended access</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.example-package {
    border-left: 4px solid #FFD700;
    padding-left: 15px;
    margin-bottom: 20px;
}
.example-package h5 {
    color: #333;
    margin-bottom: 10px;
}
.example-package ul {
    margin-bottom: 0;
}
</style>

{include file="sections/footer.tpl"}
{* Use cache busting version from CSS template *}
{assign var="js_version" value="20250716"}

<!-- JavaScript Configuration -->
<script>
    var appUrl = '{$app_url}';
    var currentUser = '{$_admin['user_type']}';
    var systemTime = new Date();
    
    // Initialize Glinta Configuration
    window.glintaConfig = {
        refreshInterval: 30000, // 30 seconds
        enableWebSocket: false,
        enableNotifications: true,
        baseUrl: '{$app_url}',
        version: '{$js_version}'
    };
</script>

<!-- Critical JavaScript - Optimized loading -->
<script src="{$app_url}/ui/ui/scripts/sweetalert2.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
<script src="{$app_url}/ui/ui/scripts/glinta-realtime.js?v={$js_version}"></script>
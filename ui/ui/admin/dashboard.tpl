{include file="sections/header.tpl"}

{function showWidget pos=0}
    {foreach $widgets as $w}
        {if $w['position'] == $pos}
            {$w['content']}
        {/if}
    {/foreach}
{/function}

<!-- Dashboard Container -->
<div class="dashboard-container">
    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h1>Glinta Africa Dashboard</h1>
        <div class="real-time-status">
            <div class="real-time-indicator"></div>
            <span>Real-time: <span class="last-update-time">Live</span></span>
        </div>
    </div>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        {assign dtipe value="dashboard_`$tipeUser`"}
        
        {assign rows explode(".", $_c[$dtipe])}
        {assign pos 1}
        {foreach $rows as $cols}
            {if $cols == 12}
                <div class="dashboard-card">
                    <div class="dashboard-card-header">
                        <h3 class="dashboard-card-title">System Overview</h3>
                    </div>
                    <div class="dashboard-card-body">
                        {showWidget widgets=$widgets pos=$pos}
                    </div>
                </div>
                {assign pos value=$pos+1}
            {else}
                {assign colss explode(",", $cols)}
                <div class="row">
                    {foreach $colss as $c}
                        <div class="col-md-{$c}">
                            <div class="dashboard-card">
                                <div class="dashboard-card-body">
                                    {showWidget widgets=$widgets pos=$pos}
                                </div>
                            </div>
                        </div>
                        {assign pos value=$pos+1}
                    {/foreach}
                </div>
            {/if}
        {/foreach}
    </div>

{if $_c['new_version_notify'] != 'disable'}
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            $.getJSON("./version.json?" + Math.random(), function(data) {
                var localVersion = data.version;
                $('#version').html('Version: ' + localVersion);
                $.getJSON(
                    "https://watsonsdevelopers.com/glinta-africa/version.json?" +
                    Math
                    .random(),
                    function(data) {
                        var latestVersion = data.version;
                        if (localVersion !== latestVersion) {
                            $('#version').html('Latest Version: ' + latestVersion);
                            if (getCookie(latestVersion) != 'done') {
                                Swal.fire({
                                    icon: 'info',
                                    title: "New Version Available\nVersion: " + latestVersion,
                                    toast: true,
                                    position: 'bottom-right',
                                    showConfirmButton: true,
                                    showCloseButton: true,
                                    timer: 30000,
                                    confirmButtonText: 'Update Available',
                                    timerProgressBar: true,
                                    didOpen: (toast) => {
                                        toast.addEventListener('mouseenter', Swal.stopTimer)
                                        toast.addEventListener('mouseleave', Swal
                                            .resumeTimer)
                                    }
                                });
                                setCookie(latestVersion, 'done', 7);
                            }
                        }
                    });
            });

        });
    </script>
{/if}

</div> <!-- Close dashboard-container -->

{include file="sections/footer.tpl"}
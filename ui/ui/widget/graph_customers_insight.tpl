<div class="panel panel-info panel-hovered mb20 activities">
    <div class="panel-heading">{Lang::T('All Users Insights')}</div>
    <div class="panel-body">
        <canvas id="userRechargesChart"></canvas>
    </div>
</div>


<script type="text/javascript">
    {literal}
        document.addEventListener("DOMContentLoaded", function() {
            console.log("Loading Customer Insights Pie Chart with Green, Red, Pink Colors...");
            // Get the data from PHP and assign it to JavaScript variables
            var u_act = '{/literal}{$u_act}{literal}';
            var c_all = '{/literal}{$c_all}{literal}';
            var u_all = '{/literal}{$u_all}{literal}';
            //lets calculate the inactive users as reported
            var expired = u_all - u_act;
            var inactive = c_all - u_all;
            if (inactive < 0) {
                inactive = 0;
            }
            // Create the chart data
            var data = {
                labels: ['Active Users', 'Expired Users', 'Inactive Users'],
                datasets: [{
                    label: 'User Recharges',
                    data: [parseInt(u_act), parseInt(expired), parseInt(inactive)],
                    backgroundColor: ['rgba(34, 139, 34, 0.8)', 'rgba(220, 53, 69, 0.8)', 'rgba(255, 20, 147, 0.8)'],
                    borderColor: ['rgba(34, 139, 34, 1)', 'rgba(220, 53, 69, 1)', 'rgba(255, 20, 147, 1)'],
                    borderWidth: 1
                }]
            };

            // Create chart options
            var options = {
                responsive: true,
                aspectRatio: 1,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            boxWidth: 15
                        }
                    }
                }
            };

            // Get the canvas element and create the chart
            var ctx = document.getElementById('userRechargesChart').getContext('2d');
            var chart = new Chart(ctx, {
                type: 'pie',
                data: data,
                options: options
            });
        });
    {/literal}
</script>
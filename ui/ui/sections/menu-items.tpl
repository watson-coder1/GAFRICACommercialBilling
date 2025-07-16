{* Menu items template for modern dashboard *}
{$_MENU_AFTER_SERVICES}
{if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
    <li class="{if $_system_menu eq 'services'}active{/if} treeview">
        <a href="#">
            <i class="fa fa-cube"></i> <span>{Lang::T('Internet Plan')}</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
        </a>
        <ul class="treeview-menu">
            <li {if $_routes[1] eq 'hotspot' }class="active" {/if}>
                <a href="{Text::url('services/hotspot')}">
                    <i class="fa fa-circle-o"></i> Hotspot
                </a>
            </li>
            <li {if $_routes[1] eq 'pppoe' }class="active" {/if}>
                <a href="{Text::url('services/pppoe')}">
                    <i class="fa fa-circle-o"></i> PPPOE
                </a>
            </li>
            <li {if $_routes[1] eq 'vpn' }class="active" {/if}>
                <a href="{Text::url('services/vpn')}">
                    <i class="fa fa-circle-o"></i> VPN
                </a>
            </li>
            <li {if $_routes[1] eq 'list' }class="active" {/if}>
                <a href="{Text::url('bandwidth/list')}">
                    <i class="fa fa-circle-o"></i> Bandwidth
                </a>
            </li>
            {if $_c['enable_balance'] == 'yes'}
                <li {if $_routes[1] eq 'balance' }class="active" {/if}>
                    <a href="{Text::url('services/balance')}">
                        <i class="fa fa-circle-o"></i> {Lang::T('Customer Balance')}
                    </a>
                </li>
            {/if}
            {$_MENU_PLANS}
        </ul>
    </li>
{/if}
{$_MENU_AFTER_PLANS}

<li class="{if in_array($_routes[0], ['maps'])}active{/if} treeview">
    <a href="#">
        <i class="fa fa-map-marker"></i> <span>{Lang::T('Maps')}</span>
        <span class="pull-right-container">
            <i class="fa fa-angle-left pull-right"></i>
        </span>
    </a>
    <ul class="treeview-menu">
        <li {if $_routes[1] eq 'customer' }class="active" {/if}>
            <a href="{Text::url('maps/customer')}">
                <i class="fa fa-circle-o"></i> {Lang::T('Customer')}
            </a>
        </li>
        <li {if $_routes[1] eq 'routers' }class="active" {/if}>
            <a href="{Text::url('maps/routers')}">
                <i class="fa fa-circle-o"></i> {Lang::T('Routers')}
            </a>
        </li>
        {$_MENU_MAPS}
    </ul>
</li>

<li class="{if $_system_menu eq 'reports'}active{/if} treeview">
    {if in_array($_admin['user_type'],['SuperAdmin','Admin', 'Report'])}
        <a href="#">
            <i class="fa fa-clipboard"></i> <span>{Lang::T('Reports')}</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
        </a>
    {/if}
    <ul class="treeview-menu">
        <li {if $_routes[1] eq 'reports' }class="active" {/if}>
            <a href="{Text::url('reports')}">
                <i class="fa fa-circle-o"></i> {Lang::T('Daily Reports')}
            </a>
        </li>
        <li {if $_routes[1] eq 'activation' }class="active" {/if}>
            <a href="{Text::url('reports/activation')}">
                <i class="fa fa-circle-o"></i> {Lang::T('Activation History')}
            </a>
        </li>
        {$_MENU_REPORTS}
    </ul>
</li>
{$_MENU_AFTER_REPORTS}

<li class="{if $_system_menu eq 'message'}active{/if} treeview">
    <a href="#">
        <i class="fa fa-comments"></i> <span>{Lang::T('Send Message')}</span>
        <span class="pull-right-container">
            <i class="fa fa-angle-left pull-right"></i>
        </span>
    </a>
    <ul class="treeview-menu">
        <li {if $_routes[1] eq 'send' }class="active" {/if}>
            <a href="{Text::url('message/send')}">
                <i class="fa fa-circle-o"></i> {Lang::T('Single Customer')}
            </a>
        </li>
        <li {if $_routes[1] eq 'send_bulk' }class="active" {/if}>
            <a href="{Text::url('message/send_bulk')}">
                <i class="fa fa-circle-o"></i> {Lang::T('Bulk Customers')}
            </a>
        </li>
        {$_MENU_MESSAGE}
    </ul>
</li>
{$_MENU_AFTER_MESSAGE}

{if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
    <li class="{if $_system_menu eq 'network'}active{/if} treeview">
        <a href="#">
            <i class="fa fa-network-wired"></i> <span>{Lang::T('Network')}</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
        </a>
        <ul class="treeview-menu">
            <li {if $_routes[0] eq 'routers' and $_routes[1] eq '' }class="active" {/if}>
                <a href="{Text::url('routers')}">
                    <i class="fa fa-circle-o"></i> Routers
                </a>
            </li>
            <li {if $_routes[0] eq 'pool' and $_routes[1] eq 'list' }class="active" {/if}>
                <a href="{Text::url('pool/list')}">
                    <i class="fa fa-circle-o"></i> IP Pool
                </a>
            </li>
            <li {if $_routes[0] eq 'pool' and $_routes[1] eq 'port' }class="active" {/if}>
                <a href="{Text::url('pool/port')}">
                    <i class="fa fa-circle-o"></i> Port Pool
                </a>
            </li>
            {$_MENU_NETWORK}
        </ul>
    </li>
    {$_MENU_AFTER_NETWORKS}
    
    {if $_c['radius_enable']}
        <li class="{if $_system_menu eq 'radius'}active{/if} treeview">
            <a href="#">
                <i class="fa fa-database"></i> <span>{Lang::T('Radius')}</span>
                <span class="pull-right-container">
                    <i class="fa fa-angle-left pull-right"></i>
                </span>
            </a>
            <ul class="treeview-menu">
                <li {if $_routes[0] eq 'radius' and $_routes[1] eq 'nas-list' }class="active" {/if}>
                    <a href="{Text::url('radius/nas-list')}">
                        <i class="fa fa-circle-o"></i> {Lang::T('Radius NAS')}
                    </a>
                </li>
                {$_MENU_RADIUS}
            </ul>
        </li>
    {/if}
    {$_MENU_AFTER_RADIUS}
    
    <li class="{if $_system_menu eq 'pages'}active{/if} treeview">
        <a href="#">
            <i class="fa fa-file-text"></i> <span>{Lang::T("Static Pages")}</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
        </a>
        <ul class="treeview-menu">
            <li {if $_routes[1] eq 'Order_Voucher' }class="active" {/if}>
                <a href="{Text::url('pages/Order_Voucher')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Order Voucher')}
                </a>
            </li>
            <li {if $_routes[1] eq 'Voucher' }class="active" {/if}>
                <a href="{Text::url('pages/Voucher')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Theme Voucher')}
                </a>
            </li>
            <li {if $_routes[1] eq 'Announcement' }class="active" {/if}>
                <a href="{Text::url('pages/Announcement')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Announcement')}
                </a>
            </li>
            <li {if $_routes[1] eq 'Announcement_Customer' }class="active" {/if}>
                <a href="{Text::url('pages/Announcement_Customer')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Customer Announcement')}
                </a>
            </li>
            <li {if $_routes[1] eq 'Registration_Info' }class="active" {/if}>
                <a href="{Text::url('pages/Registration_Info')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Registration Info')}
                </a>
            </li>
            <li {if $_routes[1] eq 'Privacy_Policy' }class="active" {/if}>
                <a href="{Text::url('pages/Privacy_Policy')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Privacy Policy')}
                </a>
            </li>
            <li {if $_routes[1] eq 'Terms_and_Conditions' }class="active" {/if}>
                <a href="{Text::url('pages/Terms_and_Conditions')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Terms and Conditions')}
                </a>
            </li>
            {$_MENU_PAGES}
        </ul>
    </li>
{/if}
{$_MENU_AFTER_PAGES}

<li class="{if $_system_menu eq 'settings' || $_system_menu eq 'paymentgateway' }active{/if} treeview">
    <a href="#">
        <i class="fa fa-cog"></i> <span>{Lang::T('Settings')}</span>
        <span class="pull-right-container">
            <i class="fa fa-angle-left pull-right"></i>
        </span>
    </a>
    <ul class="treeview-menu">
        {if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
            <li {if $_routes[1] eq 'app' }class="active" {/if}>
                <a href="{Text::url('settings/app')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('General Settings')}
                </a>
            </li>
            <li {if $_routes[1] eq 'localisation' }class="active" {/if}>
                <a href="{Text::url('settings/localisation')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Localisation')}
                </a>
            </li>
            <li {if $_routes[0] eq 'customfield' }class="active" {/if}>
                <a href="{Text::url('customfield')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Custom Fields')}
                </a>
            </li>
            <li {if $_routes[1] eq 'miscellaneous' }class="active" {/if}>
                <a href="{Text::url('settings/miscellaneous')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Miscellaneous')}
                </a>
            </li>
            <li {if $_routes[1] eq 'maintenance' }class="active" {/if}>
                <a href="{Text::url('settings/maintenance')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Maintenance Mode')}
                </a>
            </li>
            <li {if $_routes[0] eq 'widgets' }class="active" {/if}>
                <a href="{Text::url('widgets')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Widgets')}
                </a>
            </li>
            <li {if $_routes[1] eq 'notifications' }class="active" {/if}>
                <a href="{Text::url('settings/notifications')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('User Notification')}
                </a>
            </li>
            <li {if $_routes[1] eq 'devices' }class="active" {/if}>
                <a href="{Text::url('settings/devices')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Devices')}
                </a>
            </li>
        {/if}
        {if in_array($_admin['user_type'],['SuperAdmin','Admin','Agent'])}
            <li {if $_routes[1] eq 'users' }class="active" {/if}>
                <a href="{Text::url('settings/users')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Administrator Users')}
                </a>
            </li>
        {/if}
        {if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
            <li {if $_routes[1] eq 'dbstatus' }class="active" {/if}>
                <a href="{Text::url('settings/dbstatus')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Backup/Restore')}
                </a>
            </li>
            <li {if $_system_menu eq 'paymentgateway' }class="active" {/if}>
                <a href="{Text::url('paymentgateway')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Payment Gateway')}
                </a>
            </li>
            {$_MENU_SETTINGS}
            <li {if $_routes[0] eq 'pluginmanager' }class="active" {/if}>
                <a href="{Text::url('pluginmanager')}">
                    <i class="fa fa-circle-o"></i> {Lang::T('Plugin Manager')}
                </a>
            </li>
        {/if}
    </ul>
</li>
{$_MENU_AFTER_SETTINGS}

{if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
    <li class="{if $_system_menu eq 'logs' }active{/if} treeview">
        <a href="#">
            <i class="fa fa-clock-o"></i> <span>{Lang::T('Logs')}</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
        </a>
        <ul class="treeview-menu">
            <li {if $_routes[1] eq 'list' }class="active" {/if}>
                <a href="{Text::url('logs/phpnuxbill')}">
                    <i class="fa fa-circle-o"></i> Glinta Africa
                </a>
            </li>
            {if $_c['radius_enable']}
                <li {if $_routes[1] eq 'radius' }class="active" {/if}>
                    <a href="{Text::url('logs/radius')}">
                        <i class="fa fa-circle-o"></i> Radius
                    </a>
                </li>
            {/if}
            <li {if $_routes[1] eq 'message' }class="active" {/if}>
                <a href="{Text::url('logs/message')}">
                    <i class="fa fa-circle-o"></i> Message
                </a>
            </li>
            {$_MENU_LOGS}
        </ul>
    </li>
{/if}
{$_MENU_AFTER_LOGS}

{if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
    <li class="{if $_routes[0] eq 'portal' || $_routes[0] eq 'packages'}active{/if} treeview">
        <a href="#">
            <i class="fa fa-wifi"></i> <span>Captive Portal</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
        </a>
        <ul class="treeview-menu">
            <li {if $_routes[0] eq 'packages'}class="active"{/if}>
                <a href="{Text::url('packages/list')}">
                    <i class="fa fa-circle-o"></i> Manage Packages
                </a>
            </li>
            <li {if $_routes[0] eq 'portal' and $_routes[1] eq 'admin'}class="active"{/if}>
                <a href="{Text::url('portal/admin')}">
                    <i class="fa fa-circle-o"></i> Portal Sessions
                </a>
            </li>
        </ul>
    </li>
{/if}
{$_MENU_AFTER_COMMUNITY}
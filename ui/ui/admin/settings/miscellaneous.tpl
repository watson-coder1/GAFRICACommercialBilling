{include file="sections/header.tpl"}
<form class="form-horizontal" method="post" role="form" action="" enctype="multipart/form-data">
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <div class="panel panel-primary panel-hovered panel-stacked mb30">
                <div class="panel-heading">
                    <div class="btn-group pull-right">
                        <button class="btn btn-primary btn-xs" title="save" name="save" value="save" type="submit"><span
                                class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span></button>
                    </div>
                    {Lang::T('Miscellaneous')}
                </div>
                <div class="panel-body">
                    <input type="hidden" name="csrf_token" value="{$csrf_token}">
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('New Version Notification')}</label>
                        <div class="col-md-5">
                            <select name="new_version_notify" id="new_version_notify" class="form-control">
                                <option value="enable" {if $_c['new_version_notify']=='enable' }selected="selected"
                                    {/if}>
                                    {Lang::T('Enabled')}
                                </option>
                                <option value="disable" {if $_c['new_version_notify']=='disable' }selected="selected"
                                    {/if}>
                                    {Lang::T('Disabled')}
                                </option>
                            </select>
                        </div>
                        <p class="help-block col-md-4"><small>
                                {Lang::T('This is to notify you when new updates is
                                available')}</small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Router Check')}</label>
                        <div class="col-md-5">
                            <select name="router_check" id="router_check" class="form-control">
                                <option value="0" {if $_c['router_check']=='0' }selected="selected" {/if}>
                                    {Lang::T('Disabled')}
                                </option>
                                <option value="1" {if $_c['router_check']=='1' }selected="selected" {/if}>
                                    {Lang::T('Enabled')}
                                </option>
                            </select>
                        </div>
                        <p class="help-block col-md-4"><small>
                                {Lang::T('If enabled, the system will notify Admin when router goes Offline,
                                If admin
                                have 10 or more router and many customers, it will get overlapping, you can
                                disabled')}
                            </small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Phone OTP Required')}</label>
                        <div class="col-md-5">
                            <select name="allow_phone_otp" id="allow_phone_otp" class="form-control">
                                <option value="no" {if $_c['allow_phone_otp']=='no' }selected="selected" {/if}>
                                    {Lang::T('No')}</option>
                                <option value="yes" {if $_c['allow_phone_otp']=='yes' }selected="selected" {/if}>
                                    {Lang::T('Yes')}
                                </option>
                            </select>
                        </div>
                        <p class="help-block col-md-4"><small>
                                {Lang::T('OTP is required when user want to change phone number and
                                registration')}</small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('OTP Method')}</label>
                        <div class="col-md-5">
                            <select name="phone_otp_type" id="phone_otp_type" class="form-control">
                                <option value="sms" {if $_c['phone_otp_type']=='sms' }selected="selected" {/if}>
                                    {Lang::T('By SMS')}
                                <option value="whatsapp" {if $_c['phone_otp_type']=='whatsapp' }selected="selected"
                                    {/if}>
                                    {Lang::T('by WhatsApp')}
                                <option value="both" {if $_c['phone_otp_type']=='both' }selected="selected" {/if}>
                                    {Lang::T('By WhatsApp and SMS')}
                                </option>
                            </select>
                        </div>
                        <p class="help-block col-md-4"><small>{Lang::T('The method which OTP will be sent to
                                user')}<br>
                                {Lang::T('For Registration and Update Phone Number')}</small></p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Email OTP Required')}</label>
                        <div class="col-md-5">
                            <select name="allow_email_otp" id="allow_email_otp" class="form-control">
                                <option value="no" {if $_c['allow_email_otp']=='no' }selected="selected" {/if}>
                                    {Lang::T('No')}</option>
                                <option value="yes" {if $_c['allow_email_otp']=='yes' }selected="selected" {/if}>
                                    {Lang::T('Yes')}
                                </option>
                            </select>
                        </div>
                        <p class="help-block col-md-4"><small>
                                {Lang::T('OTP is required when user want to change Email Address')}
                            </small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Show Bandwidth Plan')}</label>
                        <div class="col-md-5">
                            <select name="show_bandwidth_plan" id="show_bandwidth_plan" class="form-control">
                                <option value="no" {if $_c['show_bandwidth_plan']=='no' }selected="selected" {/if}>
                                    {Lang::T('No')}</option>
                                <option value="yes" {if $_c['show_bandwidth_plan']=='yes' }selected="selected" {/if}>
                                    {Lang::T('Yes')}</option>
                            </select>
                        </div>
                        <p class="help-block col-md-4"><small>
                                {Lang::T('Display bandwidth plan for customer')}</small></p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Hotspot Auth Method')}</label>
                        <div class="col-md-5">
                            <select name="hs_auth_method" id="auth_method" class="form-control">
                                <option value="api" {if $_c['hs_auth_method']=='api' }selected="selected" {/if}>
                                    {Lang::T('Api')}
                                </option>
                                <option value="hchap" {if $_c['hs_auth_method']=='hchap' }selected="selected" {/if}>
                                    {Lang::T('Http-Chap')}
                                </option>
                            </select>
                        </div>
                        <p class="help-block col-md-4"><small>
                                {Lang::T('Hotspot Authentication Method. Make sure you have changed your
                                hotspot login
                                page.')} <a href="https://github.com/agstrxyz/phpnuxbill-login-hotspot"
                                    target="_blank">Download
                                    phpnuxbill-login-hotspot</a></small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Radius Rest Interim-Update')}</label>
                        <div class="col-md-5">
                            <input type="number" class="form-control" id="frrest_interim_update" name="frrest_interim_update"
                                value="{if $_c['frrest_interim_update']}{$_c['frrest_interim_update']}{else}0{/if}">
                        </div>
                        <p class="help-block col-md-4"><small>
                                {Lang::T('in minutes, leave 0 to disable this feature.')}</small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Check if Customer Online')}</label>
                        <div class="col-md-5">
                            <select name="check_customer_online" id="check_customer_online" class="form-control">
                                <option value="no">
                                    {Lang::T('No')}
                                </option>
                                <option value="yes" {if $_c['check_customer_online']=='yes' }selected="selected" {/if}>
                                    {Lang::T('Yes')}
                                </option>
                            </select>
                        </div>
                        <p class="help-block col-md-4"><small>
                                {Lang::T('This will show is Customer currently is online or not')}</small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Extend Package Expiry')}</label>
                        <div class="col-md-5">
                            <select name="extend_expiry" id="extend_expiry" class="form-control">
                                <option value="yes" {if $_c['extend_expiry']!='no' }selected="selected" {/if}>
                                    {Lang::T('Yes')}</option>
                                <option value="no" {if $_c['extend_expiry']=='no' }selected="selected" {/if}>
                                    {Lang::T('No')}</option>
                            </select>
                        </div>
                        <p class="help-block col-md-4">
                            <small> {Lang::T('If user buy same internet plan, expiry date will
                                extend')}</small>
                        </p>
                    </div>
                </div>
            </div>

            <!-- M-Pesa Configuration Panel -->
            <div class="panel panel-info panel-hovered panel-stacked mb30">
                <div class="panel-heading">
                    {Lang::T('M-Pesa Daraja API Configuration')}
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Environment')}</label>
                        <div class="col-md-5">
                            <select name="mpesa_environment" id="mpesa_environment" class="form-control">
                                <option value="sandbox" {if $_c['mpesa_environment']=='sandbox' }selected="selected" {/if}>
                                    {Lang::T('Sandbox (Testing)')}
                                </option>
                                <option value="live" {if $_c['mpesa_environment']=='live' }selected="selected" {/if}>
                                    {Lang::T('Live (Production)')}
                                </option>
                            </select>
                        </div>
                        <p class="help-block col-md-4"><small>
                                {Lang::T('Use Sandbox for testing, Live for production')}</small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Consumer Key')}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="mpesa_consumer_key" name="mpesa_consumer_key"
                                value="{if $_c['mpesa_consumer_key']}{$_c['mpesa_consumer_key']}{/if}">
                        </div>
                        <p class="help-block col-md-3"><small>
                                {Lang::T('M-Pesa API Consumer Key from Safaricom Developer Portal')}</small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Consumer Secret')}</label>
                        <div class="col-md-6">
                            <input type="password" class="form-control" id="mpesa_consumer_secret" name="mpesa_consumer_secret"
                                value="{if $_c['mpesa_consumer_secret']}{$_c['mpesa_consumer_secret']}{/if}">
                        </div>
                        <p class="help-block col-md-3"><small>
                                {Lang::T('M-Pesa API Consumer Secret from Safaricom Developer Portal')}</small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Business Short Code')}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="mpesa_shortcode" name="mpesa_shortcode"
                                value="{if $_c['mpesa_shortcode']}{$_c['mpesa_shortcode']}{/if}">
                        </div>
                        <p class="help-block col-md-3"><small>
                                {Lang::T('M-Pesa Business Short Code (Paybill or Till Number)')}</small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Passkey')}</label>
                        <div class="col-md-6">
                            <input type="password" class="form-control" id="mpesa_passkey" name="mpesa_passkey"
                                value="{if $_c['mpesa_passkey']}{$_c['mpesa_passkey']}{/if}">
                        </div>
                        <p class="help-block col-md-3"><small>
                                {Lang::T('M-Pesa Lipa Na M-Pesa Online Passkey')}</small>
                        </p>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">{Lang::T('Callback URL')}</label>
                        <div class="col-md-6">
                            <input type="url" class="form-control" id="mpesa_callback_url" name="mpesa_callback_url"
                                value="{if $_c['mpesa_callback_url']}{$_c['mpesa_callback_url']}{else}https://glintaafrica.com/portal/callback{/if}">
                        </div>
                        <p class="help-block col-md-3"><small>
                                {Lang::T('URL where M-Pesa will send payment confirmations')}</small>
                        </p>
                    </div>
                    <div class="alert alert-info">
                        <strong>Instructions:</strong>
                        <ol>
                            <li>Register on <a href="https://developer.safaricom.co.ke" target="_blank">Safaricom Developer Portal</a></li>
                            <li>Create a new app and get Consumer Key & Secret</li>
                            <li>For Sandbox, use test credentials. For Live, use your business credentials</li>
                            <li>Configure your callback URL in Safaricom portal: <strong>{$app_url}/portal/callback</strong></li>
                        </ol>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <div class="form-group">
                    <button class="btn btn-success btn-block" name="save" value="save" type="submit">
                        {Lang::T('Save Changes')}
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>

{include file="sections/footer.tpl"}

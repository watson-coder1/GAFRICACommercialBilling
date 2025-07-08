{include file="sections/header.tpl"}

<form class="form-horizontal" method="post" role="form" action="{Text::url('settings/notifications-post')}">
    <input type="hidden" name="csrf_token" value="{$csrf_token}">
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <div class="panel panel-primary panel-hovered panel-stacked mb30">
                <div class="panel-heading">
                    <div class="btn-group pull-right">
                        <button class="btn btn-primary btn-xs" title="save" type="submit"><span
                                class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span></button>
                    </div>
                    {Lang::T('User Notification')}
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Expired Notification Message')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="expired" name="expired"
                                placeholder="{Lang::T('Hello')} [[name]], {Lang::T('your internet package')} [[package]] {Lang::T('has been expired')}"
                                rows="4">{if $_json['expired']!=''}{Lang::htmlspecialchars($_json['expired'])}{else}{Lang::T('Hello')} [[name]], {Lang::T('your internet package')} [[package]] {Lang::T('has been expired')}.{/if}</textarea>
                        </div>
                        <p class="help-block col-md-4">
                            <b>[[name]]</b> - {Lang::T('will be replaced with Customer Name')}.<br>
                            <b>[[username]]</b> - {Lang::T('will be replaced with Customer username')}.<br>
                            <b>[[package]]</b> - {Lang::T('will be replaced with Package name')}.<br>
                            <b>[[price]]</b> - {Lang::T('will be replaced with Package price')}.<br>
                            <b>[[bills]]</b> - {Lang::T('additional bills for customers')}.<br>
                            <b>[[payment_link]]</b> - <a href="{$app_url}/docs/#Reminder%20with%20payment%20link"
                                target="_blank">{Lang::T("read documentation")}</a>.
                        </p>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Reminder 7 days')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="reminder_7_day" name="reminder_7_day"
                                rows="4">{Lang::htmlspecialchars($_json['reminder_7_day'])}</textarea>
                        </div>
                        <p class="help-block col-md-4">
                            <b>[[name]]</b> - {Lang::T('will be replaced with Customer Name')}.<br>
                            <b>[[username]]</b> - {Lang::T('will be replaced with Customer username')}.<br>
                            <b>[[package]]</b> - {Lang::T('will be replaced with Package name')}.<br>
                            <b>[[price]]</b> - {Lang::T('will be replaced with Package price')}.<br>
                            <b>[[expired_date]]</b> - {Lang::T('will be replaced with Expiration date')}.<br>
                            <b>[[bills]]</b> - {Lang::T('additional bills for customers')}.<br>
                            <b>[[payment_link]]</b> - <a href="{$app_url}/docs/#Reminder%20with%20payment%20link"
                                target="_blank">{Lang::T("read documentation")}</a>.
                        </p>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Reminder 3 days')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="reminder_3_day" name="reminder_3_day"
                                rows="4">{Lang::htmlspecialchars($_json['reminder_3_day'])}</textarea>
                        </div>
                        <p class="help-block col-md-4">
                            <b>[[name]]</b> - {Lang::T('will be replaced with Customer Name')}.<br>
                            <b>[[username]]</b> - {Lang::T('will be replaced with Customer username')}.<br>
                            <b>[[package]]</b> - {Lang::T('will be replaced with Package name')}.<br>
                            <b>[[price]]</b> - {Lang::T('will be replaced with Package price')}.<br>
                            <b>[[expired_date]]</b> - {Lang::T('will be replaced with Expiration date')}.<br>
                            <b>[[bills]]</b> - {Lang::T('additional bills for customers')}.<br>
                            <b>[[payment_link]]</b> - <a href="{$app_url}/docs/#Reminder%20with%20payment%20link"
                                target="_blank">{Lang::T("read documentation")}</a>.
                        </p>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Reminder 1 day')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="reminder_1_day" name="reminder_1_day"
                                rows="4">{Lang::htmlspecialchars($_json['reminder_1_day'])}</textarea>
                        </div>
                        <p class="help-block col-md-4">
                            <b>[[name]]</b> - {Lang::T('will be replaced with Customer Name')}.<br>
                            <b>[[username]]</b> - {Lang::T('will be replaced with Customer username')}.<br>
                            <b>[[package]]</b> - {Lang::T('will be replaced with Package name')}.<br>
                            <b>[[price]]</b> - {Lang::T('will be replaced with Package price')}.<br>
                            <b>[[expired_date]]</b> - {Lang::T('will be replaced with Expiration date')}.<br>
                            <b>[[bills]]</b> - {Lang::T('additional bills for customers')}.<br>
                            <b>[[payment_link]]</b> - <a href="{$app_url}/docs/#Reminder%20with%20payment%20link"
                                target="_blank">{Lang::T("read documentation")}</a>.
                        </p>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Invoice Notification Payment')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="invoice_paid" name="invoice_paid"
                                placeholder="{Lang::T('Hello')} [[name]], {Lang::T('your internet package')} [[package]] {Lang::T('has been expired')}"
                                rows="20">{Lang::htmlspecialchars($_json['invoice_paid'])}</textarea>
                        </div>
                        <p class="col-md-4 help-block">
                            <b>[[company_name]]</b> {Lang::T('Your Company Name at Settings')}.<br>
                            <b>[[address]]</b> {Lang::T('Your Company Address at Settings')}.<br>
                            <b>[[phone]]</b> - {Lang::T('Your Company Phone at Settings')}.<br>
                            <b>[[invoice]]</b> - {Lang::T('Invoice number')}.<br>
                            <b>[[date]]</b> - {Lang::T('Date invoice created')}.<br>
                            <b>[[payment_gateway]]</b> - {Lang::T('Payment gateway user paid from')}.<br>
                            <b>[[payment_channel]]</b> - {Lang::T('Payment channel user paid from')}.<br>
                            <b>[[type]]</b> - {Lang::T('is Hotspot or PPPOE')}.<br>
                            <b>[[plan_name]]</b> - {Lang::T('Internet Package')}.<br>
                            <b>[[plan_price]]</b> - {Lang::T('Internet Package Prices')}.<br>
                            <b>[[name]]</b> - {Lang::T('Receiver name')}.<br>
                            <b>[[user_name]]</b> - {Lang::T('Username internet')}.<br>
                            <b>[[user_password]]</b> - {Lang::T('User password')}.<br>
                            <b>[[expired_date]]</b> - {Lang::T('Expired datetime')}.<br>
                            <b>[[footer]]</b> - {Lang::T('Invoice Footer')}.<br>
                            <b>[[note]]</b> - {Lang::T('For Notes by admin')}.<br>
                            <b>[[invoice_link]]</b> - <a href="{$app_url}/docs/#Reminder%20with%20payment%20link"
                            target="_blank">{Lang::T("read documentation")}</a>.
                        </p>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Balance Notification Payment')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="invoice_balance" name="invoice_balance"
                                placeholder="{Lang::T('Hello')} [[name]], {Lang::T('your internet package')} [[package]] {Lang::T('has been expired')}"
                                rows="20">{Lang::htmlspecialchars($_json['invoice_balance'])}</textarea>
                        </div>
                        <p class="col-md-4 help-block">
                            <b>[[company_name]]</b> - {Lang::T('Your Company Name at Settings')}.<br>
                            <b>[[address]]</b> - {Lang::T('Your Company Address at Settings')}.<br>
                            <b>[[phone]]</b> - {Lang::T('Your Company Phone at Settings')}.<br>
                            <b>[[invoice]]</b> - {Lang::T('Invoice number')}.<br>
                            <b>[[date]]</b> - {Lang::T('Date invoice created')}.<br>
                            <b>[[payment_gateway]]</b> - {Lang::T('Payment gateway user paid from')}.<br>
                            <b>[[payment_channel]]</b> - {Lang::T('Payment channel user paid from')}.<br>
                            <b>[[type]]</b> - {Lang::T('is Hotspot or PPPOE')}.<br>
                            <b>[[plan_name]]</b> - {Lang::T('Internet Package')}.<br>
                            <b>[[plan_price]]</b> - {Lang::T('Internet Package Prices')}.<br>
                            <b>[[name]]</b> - {Lang::T('Receiver name')}.<br>
                            <b>[[user_name]]</b> - {Lang::T('Username internet')}.<br>
                            <b>[[user_password]]</b> - {Lang::T('User password')}.<br>
                            <b>[[trx_date]]</b> - {Lang::T('Transaction datetime')}.<br>
                            <b>[[balance_before]]</b> - {Lang::T('Balance Before')}.<br>
                            <b>[[balance]]</b> - {Lang::T('Balance After')}.<br>
                            <b>[[footer]]</b> - {Lang::T('Invoice Footer')}.
                        </p>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Welcome Message')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="welcome_message" name="welcome_message"
                                rows="4">{Lang::htmlspecialchars($_json['welcome_message'])}</textarea>
                        </div>
                        <p class="help-block col-md-4">
                            <b>[[name]]</b> - {Lang::T('will be replaced with Customer Name')}.<br>
                            <b>[[username]]</b> - {Lang::T('will be replaced with Customer username')}.<br>
                            <b>[[password]]</b> - {Lang::T('will be replaced with Customer password')}.<br>
                            <b>[[url]]</b> - {Lang::T('will be replaced with Customer Portal URL')}.<br>
                            <b>[[company]]</b> - {Lang::T('will be replaced with Company Name')}.<br>
                        </p>
                    </div>
                </div>
                {if $_c['enable_balance'] == 'yes'}
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Send Balance')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="balance_send" name="balance_send"
                                rows="4">{if $_json['balance_send']}{Lang::htmlspecialchars($_json['balance_send'])}{else}{Lang::htmlspecialchars($_default['balance_send'])}{/if}</textarea>
                        </div>
                        <p class="col-md-4 help-block">
                            <b>[[name]]</b> - {Lang::T('Receiver name')}.<br>
                            <b>[[balance]]</b> - {Lang::T('how much balance have been send')}.<br>
                            <b>[[current_balance]]</b> - {Lang::T('Current Balance')}.
                        </p>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Received Balance')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="balance_received" name="balance_received"
                                rows="4">{if $_json['balance_received']}{Lang::htmlspecialchars($_json['balance_received'])}{else}{Lang::htmlspecialchars($_default['balance_received'])}{/if}</textarea>
                        </div>
                        <p class="col-md-4 help-block">
                            <b>[[name]]</b> - {Lang::T('Sender name')}.<br>
                            <b>[[balance]]</b> - {Lang::T('how much balance have been received')}.<br>
                            <b>[[current_balance]]</b> - {Lang::T('Current Balance')}.
                        </p>
                    </div>
                </div>
                {/if}
               {* <div class="panel-body">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('PDF Invoice Template')}</label>
                        <div class="col-md-6">
                            <textarea class="form-control" id="email_invoice" name="email_invoice"
                                placeholder="{Lang::T('Template for sending pdf invoice')}" rows="20">
                            {if !empty($_json['email_invoice'])}
                            {Lang::htmlspecialchars($_json['email_invoice'])}
                            {else}
                            {Lang::htmlspecialchars($_default['email_invoice'])}
                            {/if}
                        </textarea>
                        </div>
                        <p class="col-md-4 help-block">
                            <b>[[company_name]]</b> {Lang::T('Your Company Name at Settings')}.<br>
                            <b>[[company_address]]</b> {Lang::T('Your Company Address at Settings')}.<br>
                            <b>[[company_phone]]</b> - {Lang::T('Your Company Phone at Settings')}.<br>
                            <b>[[invoice]]</b> - {Lang::T('Invoice number')}.<br>
                            <b>[[created_at]]</b> - {Lang::T('Date invoice created')}.<br>
                            <b>[[payment_gateway]]</b> - {Lang::T('Payment gateway user paid from')}.<br>
                            <b>[[payment_channel]]</b> - {Lang::T('Payment channel user paid from')}.<br>
                            <b>[[bill_rows]]</b> - {Lang::T('Bills table, where bills are listed')}.<br>
                            <b>[[currency]]</b> - {Lang::T('Your currency code at localisation Settings')}.<br>
                            <b>[[status]]</b> - {Lang::T('Invoice status')}.<br>
                            <b>[[fullname]]</b> - {Lang::T('Receiver name')}.<br>
                            <b>[[user_name]]</b> - {Lang::T('Username internet')}.<br>
                            <b>[[email]]</b> - {Lang::T('Customer email')} .<br>
                            <b>[[phone]]</b> - {Lang::T('Customer phone')}. <br>
                            <b>[[address]]</b> - {Lang::T('Customer phone')}. <br>
                            <b>[[expired_date]]</b> - {Lang::T('Expired datetime')}.<br>
                            <b>[[logo]]</b> - {Lang::T('Your company logo at Settings')}.<br>
                            <b>[[due_date]]</b> - {Lang::T('Invoice Due date, 7 Days after invoice created')}.<br>
                            <b>[[payment_link]]</b> - <a href="{$app_url}/docs/#Reminder%20with%20payment%20link"
                                target="_blank">{Lang::T("read documentation")}</a>.
                        </p>
                    </div>
                </div> *}

                <div class="panel-body">
                    <div class="form-group">
                        <button class="btn btn-success btn-block" type="submit">{Lang::T('Save Changes')}</button>
                    </div>
                </div>
            </div>
        </div>
</form>
{include file="sections/footer.tpl"}
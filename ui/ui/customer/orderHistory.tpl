{include file="customer/header.tpl"}
<!-- user-orderHistory -->

<div class="row">
    <div class="col-sm-12">
        <div class="panel mb20 panel-hovered panel-primary">
            <div class="panel-heading">{Lang::T('Order History')}</div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="datatable" class="table table-bordered table-striped table-condensed">
                        <thead>
                            <tr>
                                <th>{Lang::T('Package Name')}</th>
                                <th>{Lang::T('Payment Method')}</th>
                                <th>Routers</th>
                                <th>{Lang::T('Type')}</th>
                                <th>{Lang::T('Package Price')}</th>
                                <th>{Lang::T('Created on')}</th>
                                <th>{Lang::T('Expires on')}</th>
                                <th>{Lang::T('Date')}</th>
                                <th>{Lang::T('Status')}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $d as $ds}
                                <tr>
                                    <td><a href="{Text::url('order/view/')}{$ds['id']}">{$ds['plan_name']}</a></td>
                                    <td>{$ds['gateway']}</td>
                                    <td>{$ds['routers']}</td>
                                    <td>{$ds['payment_channel']}</td>
                                    <td>{Lang::moneyFormat($ds['price'])}</td>
                                    <td class="text-primary">{date("{$_c['date_format']} H:i",
                                        strtotime($ds['created_date']))}</td>
                                    <td class="text-danger">{date("{$_c['date_format']} H:i",
                                        strtotime($ds['expired_date']))}</td>
                                    <td class="text-success">{if $ds['status']!=1}{date("{$_c['date_format']} H:i",
                                        strtotime($ds['paid_date']))}{/if}</td>
                                    <td>{if $ds['status']==1}{Lang::T('UNPAID')}
                                        {elseif $ds['status']==2}{Lang::T('PAID')}
                                        {elseif $ds['status']==3}{$_L['FAILED']}
                                        {elseif $ds['status']==4}{Lang::T('CANCELED')}
                                        {elseif $ds['status']==5}{Lang::T('UNKNOWN')}
                                        {/if}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                {include file="pagination.tpl"}
            </div>
        </div>
    </div>
</div>


{include file="customer/footer.tpl"}
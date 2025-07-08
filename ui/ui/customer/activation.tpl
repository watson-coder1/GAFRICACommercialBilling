{include file="customer/header.tpl"}
<!-- user-activation -->

<div class="row">
    <div class="col-md-8">
        <div class="box box-primary box-solid">
            <div class="box-header">
                <h3 class="box-title">{Lang::T('Order Voucher')}</h3>
            </div>
            <div class="box-body">
                {include file="$PAGES_PATH/Order_Voucher.html"}
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="box box-primary box-solid">
            <div class="box-header">{Lang::T('Voucher Activation')}</div>
            <div class="box-body">
                <form method="post" role="form" action="{Text::url('voucher/activation-post')}">
                    <div class="form-group">
                        <div class="input-group">
                            <input type="text" class="form-control" id="code" name="code" value="{$code|escape:'html'}"
                                placeholder="{Lang::T('Enter voucher code here')}">
                            <span class="input-group-btn">
                                <a class="btn btn-default"
                                    href="{$app_url|escape:'html'}/scan/?back={urlencode(Text::url('voucher/activation&code='))}"><i
                                        class="glyphicon glyphicon-qrcode"></i></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-offset-2 col-lg-10">
                            <button class="btn btn-success" type="submit">{Lang::T('Recharge')}</button>
                            Or <a href="{Text::url('home')}">{Lang::T('Cancel')}</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

{include file="customer/footer.tpl"}

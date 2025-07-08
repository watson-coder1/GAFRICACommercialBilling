{include file="customer/header.tpl"}

<!-- user-phone-update -->

<div class="box box-danger">
    <div class="box-header with-border">
        <h3 class="box-title">{Lang::T('Change Phone Number')}</h3>
    </div>
    <div class="box-body">
        <div class="form-horizontal">
            <div class="form-group">
                <label class="col-md-2 control-label">{Lang::T('Current Number')}</label>
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">+</span>
                        <input type="text" class="form-control" name="phonenumber" id="phonenumber"
                            value="{$_user['phonenumber']}" readonly placeholder="{Lang::T('Phone Number')}">
                    </div>
                </div>
            </div>
            <form method="post" role="form" action="{Text::url('accounts/phone-update-otp')}">
                <input type="hidden" name="csrf_token" value="{$csrf_token}">
                <div class="form-group">
                    <label class="col-md-2 control-label">{Lang::T('New Number')}</label>
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">+</span>
                            <input type="number" class="form-control" name="phone" id="phone" value="{$new_phone}"
                                required placeholder="{Lang::T('Input your phone number')}">
                            <span class="input-group-btn">
                                <button type="submit" class="btn btn-info btn-flat">{Lang::T('Request OTP')}</button>
                            </span>
                        </div>
                    </div>
                </div>
            </form>
            <form method="post" role="form" action="{Text::url('accounts/phone-update-post')}">
                <input type="hidden" name="csrf_token" value="{$csrf_token}">
                <!-- Form 2 -->
                <div class="form-group">
                    <label class="col-md-2 control-label">{Lang::T('OTP')}</label>
                    <div class="col-md-6">
                        <input type="number" class="form-control" id="otp" name="otp"
                            placeholder="{Lang::T('Enter OTP that was sent to your phone')}" required>
                    </div>
                </div>

                <!-- Hidden field to store the phone number value -->
                <input type="hidden" name="phone" id="hidden_phone" required>

                <div class="form-group">
                    <div class="col-md-offset-3 col-m2-6">
                        <button class="btn btn-success" type="submit"
                            onclick="return validateForm()">{Lang::T('Update')}</button>
                        Or <a href="{Text::url('home')}">{Lang::T('Cancel')}</a>
                    </div>
                </div>
            </form>

            <script>
                function validateForm() {
                    var phoneNumber = document.getElementById("phone").value;
                    var otp = document.getElementById("otp").value;

                    if (phoneNumber.trim() === "") {
                        alert("Phone number is required.");
                        return false; // Prevent form submission
                    }

                    if (otp.trim() === "") {
                        alert("OTP code is required.");
                        return false; // Prevent form submission
                    }

                    // Set the phone number value in the hidden field
                    document.getElementById("hidden_phone").value = phoneNumber;
                }
            </script>
        </div>
    </div>
</div>
{include file="customer/footer.tpl"}
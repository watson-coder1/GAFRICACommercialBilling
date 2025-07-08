<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Error - Glinta Africa</title>
    <link rel="shortcut icon" href="{$app_url}/ui/ui/images/logo.png" type="image/x-icon" />

    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">

    <link rel="stylesheet" href="{$app_url}/ui/ui/fonts/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="{$app_url}/ui/ui/fonts/font-awesome/css/font-awesome.min.css">

    <link rel="stylesheet" href="{$app_url}/ui/ui/styles/modern-AdminLTE.min.css">

    <style>
        ::-moz-selection {
            /* Code for Firefox */
            color: red;
            background: yellow;
        }

        ::selection {
            color: red;
            background: yellow;
        }
    </style>

</head>

<body class="hold-transition skin-blue">
    <div class="container">

        <section class="content">
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <div class="box box-danger box-solid">
                        <section class="content-header">
                            <h1 class="text-center">
                                {$error_title}
                            </h1>
                        </section>
                        <div class="box-body" style="font-size: larger;">
                            <center>
                            <img src="{$app_url}/ui/ui/images/error.png" class="img-responsive hidden-sm hidden-xs"></center>
                            <br>
                            {$error_message}
                            <br>
                            Mikrotik troubleshooting: <br>
                            <ul>
                                <li>{Lang::T('Make sure you use API Port, Default 8728')}</li>
                                <li>{Lang::T('Make sure Username and Password are correct')}</li>
                                <li>{Lang::T('Make sure your hosting not blocking port to external')}</li>
                                <li>{Lang::T('Make sure your Mikrotik accessible from Glinta Africa')}</li>
                            </ul>
                            {Lang::T('If you just update Glinta Africa from upload files, try click Update')} Database
                        </div>
                        <div class="box-footer">
                            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                <a href="./update.php?step=4" style="color: black;" class="btn btn-info btn-sm btn-block">{Lang::T('Update')} Database</a>
                                <a href="https://watsonsdevelopers.com" style="color: black;" class="btn btn-success btn-sm btn-block">{Lang::T('Update Glinta Africa')}</a>
                            </div>
                            <br>
                            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                            <a href="https://watsonsdevelopers.com/support" target="_blank"
                            class="btn btn-success btn-sm btn-block" style="color: black;">Get Support</a>
                                <a href="https://watsonsdevelopers.com/contact" target="_blank"
                                    class="btn btn-primary btn-sm btn-block">Contact Support</a>
                            </div>
                            <br><br>
                            <a href="javascript::history.back()" onclick="history.back()"
                                class="btn btn-warning btn-block">{Lang::T('Back')}</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <img src="{$app_url}/ui/ui/images/error.png" class="img-responsive hidden-md hidden-lg">
                </div>
            </div>
        </section>
    </div>
</body>

</html>

{* Set cache busting version *}
{assign var="css_version" value="20250716"}
{assign var="js_version" value="20250716"}

<!-- Preload critical resources -->
<link rel="preload" href="{$app_url}/ui/ui/styles/bootstrap.min.css" as="style">
<link rel="preload" href="{$app_url}/ui/ui/styles/glinta-modern.css?v={$css_version}" as="style">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<!-- Critical CSS - Optimized loading order -->
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/bootstrap.min.css">
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/modern-AdminLTE.min.css">
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/glinta-modern.css?v={$css_version}">

<!-- Icon fonts - Load after critical CSS -->
<link rel="stylesheet" href="{$app_url}/ui/ui/fonts/ionicons/css/ionicons.min.css">
<link rel="stylesheet" href="{$app_url}/ui/ui/fonts/font-awesome/css/font-awesome.min.css">

<!-- Plugin CSS - Load after core styles -->
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/select2.min.css">
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/select2-bootstrap.min.css">
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/sweetalert2.min.css">
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/plugins/pace.css">
<link rel="stylesheet" href="{$app_url}/ui/ui/summernote/summernote.min.css">

<!-- Additional theme CSS - Load last -->
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/glinta.css?v={$css_version}">
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/glinta-mobile.css?v={$css_version}">
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/glinta-header-overrides.css?v={$css_version}">
<link rel="stylesheet" href="{$app_url}/ui/ui/styles/7.css?v={$css_version}">

<!-- Google Fonts - Load asynchronously -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Poppins:wght@300;400;500;600;700;800&family=Dancing+Script:wght@400;700&family=Lobster&display=swap" rel="stylesheet" media="print" onload="this.media='all'">
<noscript>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Poppins:wght@300;400;500;600;700;800&family=Dancing+Script:wght@400;700&family=Lobster&display=swap" rel="stylesheet">
</noscript>
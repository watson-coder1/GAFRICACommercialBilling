{include file="customer/header-public.tpl"}


<style>
.err-container {
    text-align: center;
    padding: 50px;
    background: #ffffff;
    border-radius: 8px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}

.m404 {
    font-size: 100px;
    color: #ff6b6b;
}

.text-desc {
    font-size: 20px;
    color: #333333;
    margin: 20px 0;
}

.error-btn {
    display: inline-block;
    padding: 10px 20px;
    font-size: 18px;
    color: #ffffff;
    background-color: #007bff;
    border-radius: 5px;
    text-decoration: none;
}

.error-btn:hover {
    background-color: #0056b3;
}
</style>

<div class="page page-err clearfix">
    <div class="err-container">
        <h1 class="m404 mb0">404 <a href="{Text::url('home')}" class="ion ion-forward" title="Go to Dashboard"></a></h1>
        <p class="text-desc mb20">{Lang::T("Oops! The page you are looking for was not found")}.</p>
        <a href="{Text::url('home')}" class="btn btn-primary error-btn">{Lang::T("Back to dashboard")}</a>
    </div>
</div>

{include file="customer/footer-public.tpl"}

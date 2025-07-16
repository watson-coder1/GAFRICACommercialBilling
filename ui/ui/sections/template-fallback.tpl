{* Template fallback for missing includes *}
{if $smarty.template|basename == 'menu-items.tpl'}
    {* If menu-items.tpl doesn't exist, load default menu structure *}
    {include file="sections/menu-items.tpl"}
{/if}
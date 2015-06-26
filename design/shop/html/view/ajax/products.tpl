{if $products}
<div class="row">
	{foreach $products as $product}
		{include file="view/product/grid.product.tpl"}
	{/foreach}
</div>
{else}
Товары не найдены
{/if}

{include file='view/base/pagination.tpl'}
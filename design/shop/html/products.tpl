{* Канонический адрес страницы *}
{if $category && $brand}
	{$canonical="/catalog/{$category->url}/{$brand->url}" scope=parent}
{elseif $category}
	{$canonical="/catalog/{$category->url}" scope=parent}
{elseif $brand}
	{$canonical="/brands/{$brand->url}" scope=parent}
{elseif $keyword}
	{$canonical="/products?keyword={$keyword|escape}" scope=parent}
{else}
	{$canonical="/products" scope=parent}
{/if}

{* Заголовок страницы *}
{if $keyword}
	{$pagetitle = $keyword|escape}
{elseif $brand}
	{$pagetitle = $brand->name|escape}
{else}
	{$pagetitle = $category->name|escape}
{/if}


{$crumbs = ['Главная'=>'./']}
{if $category}
	{foreach $category->path as $cat}
		{if !$cat@last}
			{$crumbs[$cat->name|escape] = 'catalog/'|cat:$cat->url}
		{/if}
	{/foreach}
{elseif $brand}
	{$crumbs[$brand->name|escape] = 'brands/'|cat:$brand->url}
{/if}


{include file='view/base/pre-header.tpl'}

{if $repeaters}
	{include file='banners.tpl'}
{/if}


<div class="container content">
	<div class="row">
		
		<div class="col-swga-3 col-htab-4">
			<aside>
				{include file='view/aside/filter.tpl'}
			</aside>
		</div>
		<div class="col-swga-9 col-htab-8">

			<div id="seo-text">
				{$page->body}
				{$brand->description}
				{$category->description}
			</div>

			<div class="products" id="products">
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
			</div>

			<div id="seo-wrapper" class="seo-text"></div>

		</div>

	</div>
</div>
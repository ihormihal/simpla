<!-- Просмотренные товары -->
{get_browsed_products var=browsed_products limit=20}
{if $browsed_products}

	<h2>Вы просматривали:</h2>
	<ul id="browsed_products">
	{foreach $browsed_products as $browsed_product}
		<li>
		<a href="products/{$browsed_product->url}"><img src="{$browsed_product->image->filename|resize:50:50}" alt="{$browsed_product->name|escape}" title="{$browsed_product->name|escape}"></a>
		</li>
	{/foreach}
	</ul>
{/if}
<!-- Просмотренные товары (The End)-->
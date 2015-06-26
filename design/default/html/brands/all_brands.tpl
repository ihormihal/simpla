<!-- Все бренды -->
{* Выбираем в переменную $all_brands все бренды *}
{get_brands var=all_brands}
{if $all_brands}
<div id="all_brands">
	<h2>Все бренды:</h2>
	{foreach $all_brands as $b}	
		{if $b->image}
		<a href="brands/{$b->url}"><img src="{$config->brands_images_dir}{$b->image}" alt="{$b->name|escape}"></a>
		{else}
		<a href="brands/{$b->url}">{$b->name}</a>
		{/if}
	{/foreach}
</div>
{/if}
<!-- Все бренды (The End)-->
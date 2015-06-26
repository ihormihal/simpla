<!-- Все бренды -->
{* Выбираем в переменную $all_brands все бренды *}
{get_brands var=all_brands}
{if $all_brands}

<h2 class="title upper">Бренды <span class="btn-show-click" data-target="#brands"><i class="fa fa-angle-down"></i></span></h2>
<div class="brands" id="brands" style="display:none;">
{foreach $all_brands as $b}	
	{if $b->image}
	<a href="brands/{$b->url}"><!--img src="{$config->brands_images_dir}{$b->image}" alt="{$b->name|escape}"></a-->
	{else}
	<a href="brands/{$b->url}">{$b->name}</a>
	{/if}
{/foreach}
</div>

{/if}
<!-- Все бренды (The End)-->
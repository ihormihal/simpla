<div class="filters">
	<form id="filter" method="get" action="/ajax/products.php">
	<input type="hidden" name="page" value="1">
	<input type="hidden" name="brand" value="{$brand->id}">
	<input type="hidden" name="category" value="{$category->children|@json_encode}">
	<div class="filter">
		<h3 class="title thin">Сортировка</h3>
		<div class="radio">
		  <input id="rd-1" type="radio" name="sort" value="position" {if $sort=='position'}checked{/if}>	
		  <label for="rd-1">Позиция (популярные)</label>
		</div>
		<div class="radio">
		  <input id="rd-2" type="radio" name="sort" value="price" {if $sort=='price'}checked{/if}>	
		  <label for="rd-2">Цена (от дешевых)</label>
		</div>
		<div class="radio">
		  <input id="rd-3" type="radio" name="sort" value="name" {if $sort=='name'}checked{/if}>	
		  <label for="rd-3">Название (А-Я)</label>
		</div>
	</div>
	<div class="filter">
		<h3 class="title thin">Стоимость</h3>
		<input name="cost" type="text" id="range" data-min="{$min_price|convert:null:false}" data-max="{$max_price|convert:null:false}" data-postfix=" {$currency->sign|escape}" data-type="double" value="" />
	</div>
	{if $features}
	{foreach $features as $f}
	<div class="filter feature-filter" data-feature="{$f->id}">
		<h3 class="title thin">{$f->name}</h3>
		{foreach $f->options as $o key=i}
		<div class="checkbox" data-feature="{$f->id}">
		  <input id="f{$f->id}_{$i}" type="checkbox" name="features[{$f->id}][]" value="{$o->value}">	
		  <label for="f{$f->id}_{$i}">{$o->value|escape}</label>
		</div>
		{/foreach}
	</div>
	{/foreach}
	{/if}
	</form>
</div>
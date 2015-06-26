<div class="show-htab nav-main-mobile">
	<nav>
		{* Рекурсивная функция вывода дерева категорий *}
		{function name=categories_tree}
		{if $categories}
		<ul>
		{foreach $categories as $c}
			{* Показываем только видимые категории *}
			{if $c->visible}
				<li class="{if $c->subcategories}parent{/if}">
					<a {if $category->id == $c->id}class="selected"{/if} href="catalog/{$c->url}" data-category="{$c->id}">{$c->name}</a>
					{categories_tree categories=$c->subcategories}
				</li>
			{/if}
		{/foreach}
		</ul>
		{/if}
		{/function}
		{categories_tree categories=$categories}
	</nav>
</div>
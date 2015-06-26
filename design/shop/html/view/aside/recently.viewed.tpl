<!-- Просмотренные товары -->
{get_browsed_products var=browsed_products limit=20}
{if $browsed_products}

	<h2 class="title upper">Вы смотрели</h2>
	<div class="recently-viewed products owl">
	{foreach $browsed_products as $browsed_product}
		<div class="product">
			<div class="product-image">
				{if $product->featured}{$hit = 1}<div class="label hit">топ продаж!</div>{/if}
				{foreach $product->variants as $v}
					{if $v->compare_price > 0}<div class="label sale" {if $hit}style="margin-top: 30px"{/if}>супер цена!</div>{/if}
				{/foreach}
				<div class="image">
					<a href="products/{$browsed_product->url}">
						<img src="{$browsed_product->image->filename|resize:200:200}" alt="">
					</a>
				</div>
			</div>
			<div class="product-info">
				<h3 class="title"><a href="products/{$browsed_product->url}">{$browsed_product->name}</a></h3>
				<div class="rating">
					<div class="stars"><div class="on" style="width: {$product->rating*20}%;"></div></div>
					<span class="rate">{$product->rating|string_format:"%.1f"}</span><span class="votes">(<i class="fa fa-user"></i> {$product->votes})</span>
				</div>
			</div>
		</div>
	{/foreach}
	</div>
{/if}
<!-- Просмотренные товары (The End)-->
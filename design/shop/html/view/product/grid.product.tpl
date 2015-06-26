<div class="col-swga-3 col-vtab-4 col-htab-6">
	<div class="product animated fadeIn">
		<div class="product-wrapper">
			<div class="product-image">
				{if $product->featured}{$hit = 1}<div class="label hit">топ продаж!</div>{/if}
				{foreach $product->variants as $v}
					{if $v->compare_price > 0}<div class="label sale" {if $hit}style="margin-top: 30px"{/if}>супер цена!</div>{/if}
				{/foreach}
				<div class="image">
					<a href="products/{$product->url}">
						<img src="{$product->image->filename|resize:200:200}" alt="">
					</a>
				</div>
			</div>
			<div class="product-info">
				<h3 class="title" data-product="{$product->id}"><a href="products/{$product->url}">{$product->name}</a></h3>
				<div class="rating">
					<div class="stars"><div class="on" style="width: {$product->rating*20}%;"></div></div>
					<span class="rate">{$product->rating|string_format:"%.1f"}</span><span class="votes">(<i class="fa fa-user"></i> {$product->votes})</span>
				</div>
				<form action="ajax/cart.php" method="GET">
					{if $product->variants|count > 0}						
						<select name="variant" class="select-source full {if $product->variants|count<2}hidden{/if}" data-target="#prices-{$product->id}">
						{foreach $product->variants as $v}
							<option {if $v@first}selected{/if}
								data-item = "{$v->id}"
								value="{$v->id}"
							>{if $v->name}{$v->name}{/if}</option>
						{/foreach}
						</select>
					{else}
					<p class="not-available">нет в наличии</p>
					{/if}
					<ul id="prices-{$product->id}" class="ul hlist">
						{foreach $product->variants as $v}
						<li data-item="{$v->id}" {if $v@first}class="active"{/if}>
							<div class="price">
								<span class="current">{if $v->price > 0}{$v->price|convert} {$currency->sign|escape}{/if}</span>
								<span class="old">{if $v->compare_price > 0}{$v->compare_price|convert}{/if}</span>
							</div>
							{if $v->cart_discount > 0}
								<div class="notes">Скидка при заказе через корзину сайта:<span>-{$v->cart_discount|convert} {$currency->sign|escape}</span></div>
							{/if}
							{if $v->custom}
								<button type="submit" class="btn btn-grey btn-to-cart"><i class="fa fa-cart-plus"></i><span>Под заказ</span></button>
							{else}
								<button type="submit" class="btn btn-blue btn-to-cart"><i class="fa fa-cart-plus"></i><span>В корзину</span></button>
							{/if}
						</li>	
						{/foreach}
					</ul>
				</form>
				<div class="description">
					{$product->annotation}
				</div>
			</div>
		</div>
	</div>
</div>
{if $cart->total_products>0}
<div id="icon">
	<a href="cart/" class="fancy cart" data-count="{$cart->total_products}" data-total="{$cart->total_price|convert} {$currency->sign|escape}">
		<i class="fa fa-shopping-cart"></i>
	</a>
</div>
<div id="popup">
	<div id="in-cart" class="popup popup-cart">
		<h3 class="title">В корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'}</h3>
		<div class="cart-list">
			<table>
				<tbody>
					{foreach from=$cart->purchases item=purchase}
					<tr>
						<td>
							<div class="image">
								<a href="products/{$purchase->product->url}">
									{$image = $purchase->product->images|first}
									<img src="{$image->filename|resize:95:95}" alt="{$product->name|escape}">
									{/else}
									<img src="design/{$settings->theme|escape}/images/no-image.png" alt="">
									{/if}
								</a>
							</div>
						</td>
						<td>
							<h3 class="name"><a href="products/{$purchase->product->url}">{$product->name|escape}</a></h3>
						</td>
						<td>
							<div class="price">{$purchase->amount} x {$purchase->variant->price|convert} {$currency->sign}
							</div>
						</td>
					</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
		{if $cart->total_discount > 0}
		<p class="text-right">Скидка: <span class="blue-text">-{$cart->total_discount|convert} {$currency->sign}</span></p>
		{/if}
		<p class="text-right">
			Всего: <b class="blue-text">{$cart->total_price|convert} {$currency->sign|escape}</b>
		</p>
		<div class="action text-center">
			<a href="#" class="btn btn-border" onclick="$.fancybox.close()">Продолжить покупки</a>
			<a href="cart/" class="btn btn-blue">Перейти в корзину</a>
		</div>
		<div class="fast-order text-center">
			<p>
				<b>Заказать без оформления</b>
				<small>Можно не заполнять никаких форм, просто оставить телефон и консультант решит все вопросы по оформлению заказа</small>
			</p>
			<form id="fast-order-form" method="post" name="cart" action="/index.php?module=CartView">
				{foreach from=$cart->purchases item=purchase}
				<input type="hidden" value="{$purchase->amount}" name="amounts[{$purchase->variant->id}]"/>
				{/foreach}
				<input type="hidden" value="11" name="delivery_id"/>

				<input class="control phone" type="text" name="phone" placeholder="(0XX) XXX-XX-XX">
				<input type="submit" class="btn btn-blue upper" value="Заказать">
			</form>
		</div>
	</div>
</div>

{else}
	<div id="icon">
		<a class="fancy cart">
			<i class="fa fa-shopping-cart"></i>
		</a>
	</div>
{/if}
{if $cart->total_products>0}

<a href="cart/" class="cart">
	<i class="fa fa-shopping-cart"></i>
	<span class="count">{$cart->total_products}</span>
	<span class="total">{$cart->total_price|convert} {$currency->sign|escape}</span>
</a>

<div id="in-cart" class="popup popup-cart">
	<form id="fast-order-form" method="post" name="cart" action="/cart/">
		<h3 class="title">В корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'}</h3>
		<div class="cart-list">
			<table>
				<tbody>
					{foreach $cart->purchases as $purchase}
					<input type="hidden" value="{$purchase->amount}" name="amounts[{$purchase->variant->id}]"/>
					<tr>
						<td>
							<div class="image">
								<a href="products/{$purchase->product->url}">
									{$image = $purchase->product->images|first}
									{if $image}
									<img src="{$image->filename|resize:100:100}" alt="{$purchase->product->name|escape}">
									{else}
									<img src="design/{$settings->theme|escape}/images/no-image.png" alt="">
									{/if}
								</a>
							</div>
						</td>
						<td>
							<h3 class="name"><a href="products/{$purchase->product->url}">{$purchase->product->name|escape} <i>{$purchase->variant->name|escape}</i></a></h3>
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
		{if $cart->cart_discount > 0}
		<p class="text-right text-small">Скидка: <span class="blue-text">-{$cart->cart_discount|convert} {$currency->sign}</span></p>
		{/if}
		<p class="text-right">
			Всего: <b class="blue-text">{$cart->total_price|convert} {$currency->sign|escape}</b>
		</p>
		<div class="action text-center">
			<a class="btn btn-border" onclick="$.fancybox.close()">Продолжить покупки</a>
			<a href="cart/" class="btn btn-blue">Перейти в корзину</a>
		</div>
		<div class="fast-order text-center">
			<p>
				<b>Заказать без оформления</b>
				<small>Можно не заполнять никаких форм, просто оставить телефон и консультант решит все вопросы по оформлению заказа</small>
			</p>
			<input class="control phone" type="text" name="phone" placeholder="(0XX) XXX-XX-XX" required>
			<input type="submit" name="fast_checkout" class="btn btn-blue upper" value="Заказать">
		</div>
	</form>
</div>

{else}
<a class="cart empty">
	<i class="fa fa-shopping-cart"></i>
</a>
{/if}
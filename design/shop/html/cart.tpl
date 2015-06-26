{$pagetitle = "Ваш заказ"}
{$meta_title = "Ваш заказ" scope=parent}

{$crumbs = ['Главная'=>'./']}

{include file="view/base/pre-header.tpl"}

<div class="shopping-cart content">
{if $cart->purchases}
<form method="post" name="cart" id="cart-form">
	<div class="container">
		<div class="steps">
			<div class="step current">1<span>. Контактные данные</span></div>
			<div class="step">2<span>. Выбор способа оплаты</span></div>
			<div class="step">3<span>. Завершение заказа</span></div>
		</div>
		<div class="gap"></div>
		<div class="purchases">
			<table class="" id="purchases">
				<!--caption>В корзине <span>3</span> товара</caption-->
				<thead>
					<tr>
						<th>Изображение товара</th>
						<th>Название товара</th>
						<th>Цена за единицу</th>
						<th>Количество</th>
						<th>Цена</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					{foreach from=$cart->purchases item=purchase}
					<tr>
						<td>
							<div class="image">
								<a href="products/{$purchase->product->url}">
									{$image = $purchase->product->images|first}
									{if $image}
									<img src="{$image->filename|resize:150:150}" alt="{$purchase->product->name|escape}">
									{else}
									<img src="design/{$settings->theme|escape}/images/no-image.png" alt="">
									{/if}
								</a>
							</div>
						</td>
						<td>
							<h3 class="name"><a href="products/{$purchase->product->url}">{$purchase->product->name|escape} <i>{$purchase->variant->name|escape}</i></a></h3>
						</td>
						<td><div class="price">{$purchase->variant->price|convert} {$currency->sign}</div></td>
						<td>
							<div class="amount">
								<input type="number" class="amounts" name="amounts[{$purchase->variant->id}]" value="{$purchase->amount}">
							</div>
						</td>
						<td><div class="price">{($purchase->variant->price*$purchase->amount)|convert} {$currency->sign}</div></td>
						<td>
							<a href="cart/remove/{$purchase->variant->id}" class="btn remove" title="Удалить из корзины"><i class="fa fa-times"></i></a>
						</td>
					</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
		<div class="gap"></div>
		<div class="gaprow row">
			<div class="col-swga-4">
				<div class="box">
					<label for="shipping-method">Выберите способ доставки</label>
					<select class="select-source full" name="delivery_id" data-target="#method-description">
						{foreach $deliveries as $method}
							<option {if $method@first}selected{/if} data-item="{$method->id}" value="{$method->id}">{$method->name}</option>
						{/foreach}
					</select>
					<ul id="method-description" class="ul methods hlist">
						{foreach $deliveries as $method}
						<li data-item="{$method->id}" {if $method@first}class="active"{/if}>
							{if $cart->total_price < $method->free_from && $method->price>0}
								<p class="blue-text upper">{$method->price|convert}&nbsp;{$currency->sign}</p>
							{elseif $cart->total_price >= $method->free_from}
								<p class="blue-text upper">бесплатно</p>
							{/if}
							<p>{$method->description}</p>
						</li>
						{/foreach}
					</ul>
				</div>
			</div>
			<div class="col-swga-4">
				{if $coupon_request}
				<div class="box">
					<label>Код купона или подарочного ваучера</label>
					<input type="text" name="coupon_code" class="control full" value="{$cart->coupon->code|escape}">
					{if $coupon_error == 'invalid'}<p class="text-right orange-text mt0">Купон недействителен</p>{/if}
					{if $cart->coupon->min_order_price>0}
					<p class="text-right {if $cart->total_price < $cart->coupon->min_order_price}orange-text{/if} mt0">купон {$cart->coupon->code|escape} действует для заказов от {$cart->coupon->min_order_price|convert} {$currency->sign}</p>
					{/if}
					<div class="text-right">
						<input type="submit" name="apply_coupon" class="btn btn-border" value="Применить купон">
					</div>
				</div>
				{/if}
			</div>
			<div class="col-swga-4">
				<div class="box">
					{if $user->discount}<p class="text-right text-small mt0">Ваша скидка: <span class="orange-text">{$user->discount} %</span></p>{/if}
					{if $cart->coupon_discount > 0}<p class="text-right text-small mt0">Ваша скидка: <span class="orange-text">-{$cart->coupon_discount|convert} {$currency->sign}</span></p>{/if}
					{if $cart->cart_discount > 0}<p class="text-right text-small mt0">Скидка при покупке через сайт: <span class="orange-text">-{$cart->cart_discount|convert} {$currency->sign|escape}</span></p>{/if}
					<p class="total text-right">Итого: <span class="blue-text">{$cart->total_price|convert} {$currency->sign}</span></p>
				</div>
			</div>
		</div>
		<div class="gap"></div>
		<div class="row">
			<div class="col-swga-4 col-vtab-6">
				<label>Имя, фамилия * {if $error == 'empty_name'}<span class="red-text">Введите Ваше имя</span>{/if}</label>
				<input type="text" name="name" class="control full" value="{$name|escape}" required>
			</div>
			<div class="col-swga-4 col-vtab-6">
				<label>E-mail * {if $error == 'empty_email'}<span class="red-text">Введите Ваш E-mail</span>{/if}</label>
				<input type="email" name="email" class="control full" value="{$email|escape}" required>
			</div>
			<div class="col-swga-4 col-vtab-6">
				<label>Телефон * {if $error == 'empty_phone'}<span class="red-text">Введите Ваш телефон</span>{/if}</label>
				<input type="text" name="phone" class="control phone full" value="{$phone|escape}">
			</div>
			<div class="col-swga-12">
				<label>Адрес доставки</label>
				<input type="text" name="address" class="control full" value="{$address|escape}">
			</div>
			<div class="col-swga-12">
				<label>Коментарий к заказу</label>
				<textarea class="full control" name="comment" rows="5">{$comment|escape}</textarea>
			</div>
			<div class="col-swga-4 col-smart-4"><img src="captcha/?PHPSESSID={$smarty.cookies.PHPSESSID}" class="captcha" alt="captcha"/></div>
			<div class="col-swga-4 col-smart-4">
				{if $error == 'captcha'}<span class="red-text">Капча введена неверно</span>{/if}
				<input type="text" name="captcha_code" class="control full" placeholder="Капча...">
			</div>
			<div class="col-swga-4 col-smart-4">
				<input type="submit" name="checkout" class="btn btn-blue btn-large upper full" value="Оформить заказ">
			</div>
		</div>
	</div>
</form>
{else}
<div class="container">
	<div class="box">
		<h2 class="grey-text">Корзина пуста</h2>
		<p>В Вашей корзине пока что нет товаров</p>
	</div>
</div>
{/if}
</div>
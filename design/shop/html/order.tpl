{$meta_title = "Ваш заказ №`$order->id`" scope=parent}
{$pagetitle = "Ваш заказ №`$order->id`"}

{$crumbs = ['Главная'=>'./']}
{include file="view/base/pre-header.tpl"}

<div class="shopping-cart content">			
	<div class="container">
		{if !$payment_method}
		<div class="steps">
			<div class="step prev">1<span>. Контактные данные</span></div>
			<div class="step current">2<span>. Выбор способа оплаты</span></div>
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
					</tr>
				</thead>
				<tbody>
					{foreach $purchases as $purchase}
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
							<h3 class="name"><a href="products/{$purchase->product->url}">{$purchase->product->name|escape} <span>{$purchase->variant->name|escape}</span></a></h3>
						</td>
						<td><div class="price">{$purchase->variant->price|convert:null:null:$purchase->product->brand_id} {$currency->sign}</div></td>
						<td><div class="amount">&times; {$purchase->amount}&nbsp;{$settings->units}</div></td>
						<td><div class="price">{($purchase->variant->price*$purchase->amount)|convert:null:null:$purchase->product->brand_id} {$currency->sign}</div></td>
					</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
		{else}
		<div class="steps">
			<div class="step prev">1<span>. Контактные данные</span></div>
			<div class="step prev">2<span>. Выбор способа оплаты</span></div>
			<div class="step current">3<span>. Завершение заказа</span></div>
		</div>
		<div class="gap"></div>
		<div class="box">
			<h1 class="blue-text text-center">Спасибо! Ваш заказ №{$order->id} {if $order->status == 0}принят{/if}{if $order->status == 1}в обработке{elseif $order->status == 2}выполнен{/if}{if $order->paid == 1}, оплачен{else}{/if}!</h1>
		</div>
		{/if}
		<form method="post">
			<div class="gap"></div>
			<div class="gaprow row">
				<div class="col-swga-4">
					<div class="box">
						<h3 class="title thin">Детали заказа</h3>
						<table class="detail">
							<tbody>
								<tr>
									<td><i class="fa fa-calendar"></i>Дата заказа:</td>
									<td>{$order->date|date} в {$order->date|time}</td>
								</tr>
								{if $order->name}
								<tr>
									<td><i class="fa fa-user"></i>Имя:</td>
									<td>{$order->name|escape}</td>
								</tr>
								{/if}
								{if $order->email}
								<tr>
									<td><i class="fa fa-envelope"></i>E-mail:</td>
									<td>{$order->email|escape}</td>
								</tr>
								{/if}
								{if $order->phone}
								<tr>
									<td><i class="fa fa-phone"></i>Телефон:</td>
									<td>{$order->phone|escape}</td>
								</tr>
								{/if}
								{if $order->address}
								<tr>
									<td><i class="fa fa-map-marker"></i>Адрес доставки:</td>
									<td>{$order->address|escape}</td>
								</tr>
								{/if}
								{if $order->comment}
								<tr>
									<td><i class="fa fa-comment"></i>Комментарий:</td>
									<td>{$order->comment|escape|nl2br}</td>
								</tr>
								{/if}
							</tbody>
						</table>
					</div>
				</div>
				<div class="col-swga-4">
					{if !$order->paid}
						{* Выбор способа оплаты *}
						{if $payment_methods && !$payment_method && $order->total_price>0}
						<div class="box">
							<h3 class="title thin">Способ оплаты</h3>
							<label for="payment-method">Выберите способ оплаты</label>
							<select class="select-source full" name="payment_method_id" data-target="#method-description">
								{foreach $payment_methods as $method}
									<option {if $method@first}selected{/if} data-item="{$method->id}" value="{$method->id}">{$method->name}</option>
								{/foreach}
							</select>
							<ul id="method-description" class="ul methods hlist">
								{foreach $payment_methods as $method}
								<li data-item="{$method->id}" {if $method@first}class="active"{/if}>
									<p>К оплате: <span class="blue-text">{$order->total_price|convert:$method->currency_id} {$all_currencies[$method->currency_id]->sign}</span></p>
									<p>{$method->description}</p>
								</li>
								{/foreach}
							</ul>
						</div>
						{else}
							<div class="box">
								<h3 class="title thin">Способ оплаты</h3>
								<p>{$payment_method->name}</p>
								<input type="submit" name="reset_payment_method" class="btn btn-border upper full" value="Выбрать другой способ оплаты">
							</div>
						{/if}
					{/if}
				</div>
				<div class="col-swga-4">
					<div class="box">
						{if $order->discount > 0}<p class="text-right">Ваша скидка: <span class="orange-text">{$order->discount} %</span></p>{/if}
						{if $order->coupon_discount > 0}<p class="text-right">Ваша скидка: <span class="orange-text">-{$order->coupon_discount|convert} {$currency->sign}</span></p>{/if}
						{if $order->cart_discount > 0}<p class="text-right">Скидка при покупке через сайт: <span class="orange-text">-{$order->cart_discount|convert} {$currency->sign|escape}</span></p>{/if}
						{* Если стоимость доставки входит в сумму заказа *}
						{if !$order->separate_delivery && $order->delivery_price>0}
						<p class="text-right">{$delivery->name|escape}: <span class="blue-text">{$order->delivery_price|convert} {$currency->sign}</span></p>
						{/if}
						<p class="total text-right">Итого: <span class="blue-text">{$order->total_price|convert} {$currency->sign}</span></p>
						{* Если стоимость доставки не входит в сумму заказа *}
						{if $order->separate_delivery}
						<p class="text-right">{$delivery->name|escape}: <span class="blue-text">{$order->delivery_price|convert} {$currency->sign}</span></p>
						{/if}
					</div>
				</div>
			</div>
			<div class="gap"></div>
			{if !$payment_method}
			<div class="row">
				<div class="col-swga-12">
					<div class="text-right">
						<input type="submit" class="btn btn-blue btn-large upper" value="Завершить заказ">
					</div>
				</div>
			</div>
			{/if}
		</form>
		{if !$order->paid}
			{if $payment_methods && $payment_method && $order->total_price>0}
				{* Форма оплаты, генерируется модулем оплаты *}
				<div class="payment-form">
				<h2 class="title">Вы можете сразу перейти к оплате Вашего заказа</h2>
				<p>К оплате: <span class="blue-text">{$order->total_price|convert:$payment_method->currency_id} {$all_currencies[$payment_method->currency_id]->sign}</span></p>
				{checkout_form order_id=$order->id module=$payment_method->module}
				</div>
			{/if}
		{/if}
	</div>
</div>
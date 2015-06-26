{$canonical = "/products/{$product->url}" scope=parent}
{$pagetitle = $product->name|escape}

{$crumbs = ['Главная'=>'./']}
{foreach $category->path as $cat}
	{$crumbs[$cat->name|escape] = 'catalog/'|cat:$cat->url}
{/foreach}

{include file='view/base/pre-header.tpl'}

<div class="header-fixed">
	<div class="container">
		<div class="row">
			<div class="col-swga-4">
				<div class="wrapper">
					<div class="image"><img src="{$product->images[0]->filename|resize:70:70}"></div>
					<div class="name">{$product->name|escape}</div>
					<div class="links">
						<a class="dotted" href="#description">Описание</a>
						{if $product->features}<a class="dotted" href="#features">Характеристики</a>{/if}
						<a class="dotted" href="./products/{$product->url}#comments">Отзывы</a>
					</div>
				</div>
			</div>
			<div class="col-swga-4">
				<div class="wrapper">
					<form action="ajax/cart.php" method="GET">
					<div class="row">
						{foreach $product->variants as $v}
							{if $v@first}{$variant = $v}{/if}
						{/foreach}
						<input type="hidden" name="variant" value="{$variant->id}">
						<div class="col-swga-4">
							<div class="price">	
								<span class="current" itemprop="price">{if $variant->price > 0}{$variant->price|convert} {$currency->sign|escape}{/if}</span>
							</div>
						</div>
						{if $product->variants|count > 0}
						<div class="col-swga-8">
							{if $variant->custom} 
							<button type="submit" class="btn btn-grey btn-to-cart"><i class="fa fa-cart-plus"></i><span>Заказать</span></button>
							{else}
							<button type="submit" class="btn btn-blue btn-to-cart"><i class="fa fa-cart-plus"></i><span>В корзину</span></button>	
							{/if}
						</div>
						{else}
						<p class="not-available">нет в наличии</p>
						{/if}
					</div>
					</form>
				</div>
			</div>
			<div class="col-swga-4">
				<div class="cart-wrapper">
					<div class="wrapper">
						<div class="row">
							<div class="col-swga-4"><div class="ajax-cart">{include file="view/ajax/cart.tpl"}</div></div>
							<div class="col-swga-8">
								<div class="ajax-cart-text">
									{if $cart->total_products>0}
									<a class="btn btn-blue" href="./cart/"><i class="fa fa-check"></i> Оформить заказ</a>
									{else}
									<p>Корзина пуста</p>
									{/if}
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container content" itemscope itemtype="http://schema.org/Product">
	<span class="hidden" itemprop="name">{$product->name|escape}</span>
	{$object_id = $product->id}
	<div class="product single">
		<div class="row">
			<div class="col-swga-4 col-vtab-6">
				<div class="product-image">
					{if $product->featured}{$hit = 1}<div class="label hit">топ продаж!</div>{/if}
					{foreach $product->variants as $v}
						{if $v->compare_price > 0}<div class="label sale" {if $hit}style="margin-top: 30px"{/if}>супер цена!</div>{/if}
					{/foreach}
					<div class="image">
						<div id="owl-slider" class="owl-carousel">
							{foreach $product->images as $image}
							<a href="{$image->filename|resize:800:800:w}" rel="images" class="item fancybox">
								<img src="{$image->filename|resize:340:340}" alt="{if $image@first}{$product->name|escape}{/if}">
							</a>
						  	{/foreach}
						</div>
						<div id="owl-carousel" class="owl-carousel">
							{foreach $product->images as $image}
							<a href="#" class="item"><img src="{$image->filename|resize:70:70}" alt=""></a>
						  	{/foreach} 
						</div>
					</div>
				</div>
			</div>
			<div class="col-swga-4 col-vtab-6">
				<div class="product-rating">
					<div class="rating" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
						<div class="stars">
							<div class="on" style="width: {$product->rating*20}%;"></div>
							<div class="live" data-id="{$product->id}">
								<span data-rate="1"></span>
								<span data-rate="2"></span>
								<span data-rate="3"></span>
								<span data-rate="4"></span>
								<span data-rate="5"></span>
							</div>
						</div>
						<span class="rate" itemprop="ratingValue">{$product->rating|string_format:"%.1f"}</span>
						<span class="votes">(<i class="fa fa-user"></i> <span itemprop="reviewCount">{$product->votes}</span>)</span>
					</div>
					<!--a href="#comments" class="comments anchor dotted"><i class="fa fa-comments-o"></i> 7 отзывов</a-->
				</div>

				<div class="description"  data-product="{$product->id}" itemprop="description">{$product->annotation}</div>
				
				<form action="ajax/cart.php" method="GET">

					{if $product->variants|count > 0}
						<p>Цена:</p>					
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
					<ul id="prices-{$product->id}" class="ul hlist" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
						{foreach $product->variants as $v}
						<li data-item="{$v->id}" {if $v@first}class="active"{/if}>
							<div class="price big">	
								<span class="old">{if $v->compare_price > 0}{$v->compare_price|convert}{/if}</span>
								<span class="current" itemprop="price">{if $v->price > 0}{$v->price|convert} {$currency->sign|escape}{/if}</span>
							</div>
							<p><a href="#check-price-cut" class="check-price-cut fancy dotted">Узнать о снижении цены</a></p>
							{if $v->cart_discount > 0}
							<p class="orange-text">Заказывай через сайт - экономь {$v->cart_discount|convert} {$currency->sign}!* 
								<small>*Скидка предоставляется автоматически при заказе через корзину.</small>
							</p>
							{/if}

							{if $v->custom}
							<div class="buttons-holder success">
								<span class="caption">под заказ</span>
								<button type="submit" class="btn btn-grey btn-to-cart"><i class="fa fa-cart-plus"></i><span>Заказать</span></button>
							</div>
							{else}
							<div class="buttons-holder success">							
								<span class="caption" href="http://schema.org/InStock">есть в наличии</span>
								<button type="submit" class="btn btn-blue btn-to-cart"><i class="fa fa-cart-plus"></i><span>В корзину</span></button>	
							</div>
							{/if}
						</li>
						{/foreach}
					</ul>	
				</form>
				<div id="check-price-cut" class="popup">
					<form action="http://shop-gsm.net/ajax/discount-call.php" method="post">
						<h3 class="title">Узнать о снижении цены</h3>
						<div class="checkbox">
							<input id="price-cut-value" type="checkbox" value="">	
							<label for="price-cut-value">когда снизится цена на:</label>
						</div>
						<input class="full control" type="text" name="price_cut" value="5%">
						<label>Ваше имя</label>
						<input class="full control" type="text" name="name" placeholder="Ваше имя">
						<label>Ваш телефон</label>
						<input class="full control phone" type="text" name="phone" placeholder="Ваш телефон">

						<input type="hidden" name="product" value="{$product->name}">
						<input type="hidden" name="url" value="{$config->root_url}/{url}">
						<input type="submit" class="btn btn-blue upper full" value="Отправить">
					</form>
				</div>
			</div>
			<div class="col-swga-4">
				<div class="box delivery">
					<div class="icon icon-car"></div>
					<h2 class="title upper">Бесплатная доставка заказов от 1000 грн!</h2>
					<div class="clear"></div>
					<p>Доставка* этого товара по Украине:</p>
					{foreach $product->variants as $v}
						{if $v@first}
							<div class="price">
							{if $v->price > 1000}
								<span class="old">30 грн</span>
								<span class="current">БЕСПЛАТНО</span>
							{else}
								<span class="current">30 грн</span>
							{/if}
							</div>
						{/if}
					{/foreach}
					<p>Гарантия: <span>12 мес</span></p>
					<p>Обмен/возврат товара в течении <span>14 дней</span></p>
					<p><small class="italic">* Доствка по Киеву и Украине осуществляется курьерскими службами "Новая Почта", "Express Mail" и др.</small></p>
					<div class="icon icon-card"></div>
					<h2 class="title upper">Оплата</h2>
					<p class="text">Вы можете оплатить картой Visa/MasterCard</p>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-swga-8">
			<div class="gap"></div>				
			<div class="horizontal-tabs">
				<ul class="ul tabs-menu">
					<li class="current"><a href="#tab-1" id="description"><i class="fa fa-file-text"></i>Описание</a></li>
					{if $product->features}<li><a href="#tab-2" id="features"><i class="fa fa-cogs"></i>Характеристики</a></li>{/if}
				</ul>
				<div class="tabs">
					<div id="tab-1" class="tab-content">
						{$product->body}
					</div>
					{if $product->features}
					<div id="tab-2" class="tab-content">
						<ul class="ul features">
							{foreach $product->features as $f}
							<li data-feature="{$f->id}">
								<span class="label">{$f->name}</span>
								<span class="value">{$f->value}</span>
							</li>
							{/foreach}
						</ul>
					</div>
					{/if}
				</div>
			</div>
			<div class="neighbors-pagination text-center">
				<div class="row">
					<div class="col-swga-6">{if $prev_product}<a href="products/{$prev_product->url}" rel="prev"><i class="fa fa-angle-left"></i>{$prev_product->name|escape}</a>{/if}</div>
					<div class="col-swga-6">{if $next_product}<a href="products/{$next_product->url}" rel="next">{$next_product->name|escape}<i class="fa fa-angle-right"></i></a>{/if}</div>
				</div>
			</div>
			{if $related_products}
			<div class="gap"></div>
			<div class="products">
				<h2 class="title upper orange-text-light"><i class="fa fa-link"></i>Также советуем посмотреть</h2>
				<div class="row gaprow">
					{foreach $related_products as $product}
						{include file="view/product/grid.product.tpl"}
					{/foreach}
				</div>
			</div>
			{/if}
		</div>
		<div class="col-swga-4">
			<aside>
				<div class="gap"></div>
				<h2 class="title upper dark-text pt05">Ваш комментарий</h2>
				<div class="ajax-content" data-url="ajax/comment.form.php?parent=0&type=product&object_id={$object_id}"></div>

				<div class="gap"></div>
				<h2 class="title upper dark-text pt05">Комментарии</h2>
				<div itemprop="reviews" itemscope itemtype="http://schema.org/Review">
					{include file="view/comments/comments.tpl"}
				</div>
			</aside>
		</div>
	</div>
</div>
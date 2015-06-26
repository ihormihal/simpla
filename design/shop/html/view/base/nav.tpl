<div class="nav-main hide-htab">
	<div class="container">
		<nav>
			{if $categories}
			<ul class="ul">
			{foreach $categories as $c}
			{if $c->visible}
				<li class="{if $category->id == $c->id}active{/if}">
					<a href="catalog/{$c->url}" data-category="{$c->id}"><span>{$c->name}</span></a>
					{if $c->subcategories}
					<div class="menu-window">
						<div class="row">

							{get_product var=category_product id=$c->product_id}

							<div class="{if $c->product_id}col-vtab-9{else}col-vtab-12{/if}">
								<ul class="sub-menu">
									{foreach $c->subcategories as $sc}
									{if $sc->visible}
									<li class="{if $category->id == $sc->id}active{/if}">
										<a href="catalog/{$sc->url}" data-category="{$sc->id}">{$sc->name}</a>
										{if $sc->subcategories}
											<ul>
												{foreach $sc->subcategories as $ssc}
												{if $ssc->visible}
												<li class="{if $category->id == $ssc->id}active{/if}"><a href="catalog/{$ssc->url}">{$ssc->name}</a></li>
												{/if}
												{/foreach}
											</ul>
										{/if}
									</li>
									{/if}
									{/foreach}
								</ul>
							</div>

							{if $c->product_id}
							<div class="col-vtab-3">
								<div class="product">
									<div class="product-wrapper">
										<div class="product-image">
											{if $category_product->featured}{$hit = 1}<div class="label hit">топ продаж!</div>{/if}
											{foreach $category_product->variants as $v}
												{if $v->compare_price > 0}<div class="label sale" {if $hit}style="margin-top: 30px"{/if}>супер цена!</div>{/if}
											{/foreach}
											<div class="image">
												<a href="products/{$category_product->url}">
													<img src="{$category_product->image->filename|resize:120:120}" alt="">
												</a>
											</div>
										</div>
										<div class="product-info">
											<h3 class="title"><a href="products/{$category_product->url}">{$category_product->name}</a></h3>
											<div class="rating">
												<div class="stars"><div class="on" style="width: {$category_product->rating*20}%;"></div></div>
												<span class="rate">{$category_product->rating|string_format:"%.1f"}</span><span class="votes">(<i class="fa fa-user"></i> {$category_product->votes})</span>
											</div>
											<form action="ajax/cart.php" method="GET">
												{if $category_product->variants|count > 0}						
													<select name="variant" class="select-source full {if $category_product->variants|count<2}hidden{/if}" data-target="#prices-{$category_product->id}">
													{foreach $category_product->variants as $v}
														<option {if $v@first}selected{/if}
															data-item = "{$v->id}"
															value="{$v->id}"
														>{if $v->name}{$v->name}{/if}</option>
													{/foreach}
													</select>
												{/if}
												<ul id="prices-{$category_product->id}" class="ul hlist">
													{foreach $category_product->variants as $v}
													<li data-item="{$v->id}" {if $v@first}class="active"{/if}>
														<div class="price">
															<span class="current">{if $v->price > 0}{$v->price|convert} {$currency->sign|escape}{/if}</span>
															<span class="old">{if $v->compare_price > 0}{$v->compare_price|convert}{/if}</span>
														</div>
														{if $v->cart_discount > 0}
															<div class="notes">Скидка при заказе через корзину сайта:<span>-{$v->cart_discount|convert} {$currency->sign|escape}</span></div>
														{/if}
														{if $v->custom}
															<button type="submit" class="btn btn-blue btn-to-cart"><i class="fa fa-cart-plus"></i><span>Под заказ</span></button>
														{else}
															<button type="submit" class="btn btn-blue btn-to-cart"><i class="fa fa-cart-plus"></i><span>В корзину</span></button>
														{/if}
													</li>	
													{/foreach}
												</ul>
											</form>
										</div>
									</div>
								</div>	
							</div>
							{/if}
						</div>
					</div>
					{/if}
				</li>
			{/if}
			{/foreach}
			</ul>
			{/if}
		</nav>
	</div>
</div>
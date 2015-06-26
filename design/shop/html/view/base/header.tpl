<header>
	<div class="top-line">
		<div class="container">
			<div class="row">
				<div class="col-swga-9 col-vtab-6">
					<nav>
						<ul class="ul hide-htab">
						{foreach $pages as $p}
						{* Выводим только страницы из первого меню *}
						{if $p->menu_id == 1}
							<li class="{if $page && $page->id == $p->id}active{/if}"><a href="{$p->url}"><i class="fa {$p->icon|escape}"></i>{$p->name|escape}</a></li>
						{/if}
						{/foreach}
						</ul>

						<select class="show-htab" onchange="window.location.href = this.value">
						{foreach $pages as $p}
						{* Выводим только страницы из первого меню *}
						{if $p->menu_id == 1}
							<option value="{$p->url}" {if $page && $page->id == $p->id}selected{/if}>{$p->name|escape}</option>
						{/if}
						{/foreach}
						</select>
					</nav>
				</div>
				<div class="col-swga-3 col-vtab-6 text-center-vtab">
					<ul class="ul float-vtab-right">
					{if $user}
						<li><a href="user"><i class="fa fa-user"></i>{$user->name}{if $group->discount>0},ваша скидка &mdash; {$group->discount}%{/if}</a></li>
						<li><a href="user/logout"><i class="fa fa-sign-out"></i>Выйти</a></li>
					{else}
						<li><a href="user/login"><i class="fa fa-sign-in"></i>Вход</a></li>
						<li><a href="user/register"><i class="fa fa-pencil"></i>Регистрация</a></li>
					{/if}
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="header-wrapper">
		<div class="container">
			<div class="row">
				<div class="col-swga-4">
					<a href="/" class="image logo">
						<img src="design/{$settings->theme|escape}/images/logo.svg" alt="">
					</a>
					<div class="show-htab gap"></div>
				</div>
				<div class="col-swga-8">
					<div class="row">
						<div class="col-vtab-7">
							<div class="row">
								<div class="padding"></div>
								<div class="col-hd-7 col-vtab-6">
									<div class="social center-smart">
										<ul class="ul">
											<li class="facebook">
												<a rel="nofollow" href="http://www.facebook.com/shopgsm" target="_blank"><i class="fa fa-facebook"></i></a>
											</li>
											<li class="vk">
												<a rel="nofollow" href="http://vk.com/shopgsmnet" target="_blank"><i class="fa fa-vk"></i></a>
											</li>
											<li class="twitter">
												<a rel="nofollow" href="http://twitter.com/shopgsm" target="_blank"><i class="fa fa-twitter"></i></a>
											</li>
											<li class="google">
												<a rel="nofollow" href="https://plus.google.com/118108612153814981947/posts" target="_blank"><i class="fa fa-google-plus"></i></a>
											</li>
											<li class="youtube">
												<a rel="nofollow" href="http://www.youtube.com/shopgsmvideo" target="_blank"><i class="fa fa-youtube"></i></a>
											</li>
										</ul>
									</div>
								</div>
								<div class="col-hd-5 col-vtab-6">
									<div class="callback center-smart">
										<a class="fancy" href="#callback" onclick="ga('send', 'event', 'Обратный звонок', 'Нажатие'); yaCounter10810246.reachGoal('Callback');"><i class="fa fa-phone"></i><span class="dotted">Обратный звонок</span></a>
									</div>
								</div>
							</div>
							<div class="gap"></div>
							<div class="row">
								<div class="col-hd-3 col-swga-3 col-vtab-3">
									<div class="ajax-cart">
										{include file="view/ajax/cart.tpl"}
									</div>
								</div>
								<div class="col-hd-9 col-swga-8 col-vtab-8">
									<div class="search-form" id="search-form">
										<div class="input-with-icon">
											<input class="input" type="text" value="" placeholder="Поиск..." autocomplete="off">
											<button type="submit" class="btn icon"><i class="fa fa-search"></i></button>
										</div>
										<div class="search-results">
											<ul class="ul results"></ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-vtab-5">
							<div class="float-vtab-right center-vtab">
								<ul class="ul phone-list">
									{foreach $places as $place}
									{if $place->phones}
									<li>
										<i class="fa fa-phone"></i><span class="city"> {$place->city}</span>
										<span class="code">{$place->phones[0]['code']}</span><span class="phone phone-xx">{$place->phones[0]['number']}</span>
										<span class="btn-show-click">
											<i class="fa"></i>
											<ul class="ul target">
												<li><span class="city">{$place->city}</span></li>
												{foreach $place->phones as $phone}
												<li><span class="code">{$phone['code']}</span><span class="phone">{$phone['number']}</span></li>
												{/foreach}
											</ul>
										</span>
									</li>
									{/if}
									{/foreach}
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	{include file="view/base/nav.tpl"}
	{include file="view/base/nav.mobile.tpl"}
</header>
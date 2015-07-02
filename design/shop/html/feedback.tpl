{* Страница с формой обратной связи *}
{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}

{$pagetitle = $page->name|escape}
{$crumbs = ['Главная'=>'./']}

{include file='view/base/pre-header.tpl'}

<div id="shop-map" class="google-map" data-pin="design/{$settings->theme|escape}/images/pin-shop.png" style="height:400px; width:100%;"></div>
<div class="container">
	<div class="horizontal-tabs contact-tabs">
		<ul class="ul tabs-menu">
			{foreach $places as $key => $place}
			<li {if $place@first}class="current"{/if} data-lat="{$place->lat}" data-lng="{$place->lng}" data-zoom="{$place->zoom}"><a href="#tab-{$key}">{$place->title}</a></li>
			{/foreach}
		</ul>
		<div class="tabs">
			{foreach $places as $key => $place}
			<div id="tab-{$key}" class="tab-content" itemscope itemtype="http://schema.org/Organization">
				{if $place->address}
				<p itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
					<i class="fa fa-map-marker"></i>
					<span itemprop="addressCountry" class="hidden">Украина</span>
					<span itemprop="addressLocality">{$place->city}</span>, <span itemprop="streetAddress">{$place->address}</span>
				</p>
				{/if}
				{if $place->description}
				<p>{$place->description}</p>
				{/if}
				<div class="gaprow row">
					<div class="col-swga-6">
						<table class="phones">
							{foreach $place->phones as $p}
							<tr>
								<td>{if $p@first}Тел.{/if}</td>
								<td itemprop="telephone">{$p['code']} {$p['number']}</td>
							</tr>
							{/foreach}
							{if $place->skype}
							<tr>
								<td>Skype:</td>
								<td>{$place->skype}</td>
							</tr>
							{/if}
							{if $place->email}
							<tr>
								<td class="c_label">E-mail:</td>
								<td itemprop="email" class="orange-text" itemprop="email">{$place->email}</td>
							</tr>
							{/if}
							
						</table>
					</div>
					<div class="col-swga-6">
					{if $place->days|count > 1}
						<table class="schedule">
							<tr>
								<td>пн</td><td>{$place->days[0]}</td>
							</tr>
							<tr>
								<td>вт</td><td>{$place->days[1]}</td>
							</tr>
							<tr>
								<td>ср</td><td>{$place->days[2]}</td>
							</tr>
							<tr>
								<td>чт</td><td>{$place->days[3]}</td>
							</tr>
							<tr>
								<td>пт</td><td>{$place->days[4]}</td>
							</tr>
							<tr class="saturday">
								<td>сб</td><td>{$place->days[5]}</td>
							</tr>
							<tr class="sunday">
								<td>вс</td><td>{$place->days[6]}</td>
							</tr>
						</table>
					{/if}
					</div>
				</div>
			</div>
			{/foreach}
		</div>
	</div>
</div>


<div class="container">{$page->body}</div>


<div class="container">
	
<h3 class="title upper orange-text"><i class="fa fa-pencil"></i> Напишите нам</h3>

	{if $message_sent}
		{$name|escape}, ваше сообщение отправлено.
	{else}

	<form method="post" id="ajax-comment-form">
		<label>Ваше имя* {if $error=='empty_name'}<span class="red-text">Введите Имя</span>{/if}</label>
		<input type="text" name="name" class="control full" value="{$name|escape}">
		<div class="row">
			<div class="col-swga-6">
				<label>Ваш email* {if $error=='empty_email'}<span class="red-text">Введите E-mail</span>{/if}</label>
				<input type="email" name="email" class="control full" value="{$email|escape}">
			</div>
			<div class="col-swga-6">
				<label>Ваше телефон</label>
				<input type="text" name="phone" class="control full" value="{$phone|escape}">
			</div>
		</div>
		<label>Комментарий* {if $error=='empty_comment'}<span class="red-text">Введите текст коментария</span>{/if}</label>
		<textarea name="text" class="control full" rows="5">{$message|escape}</textarea>
		<div class="row">
			<div class="col-swga-6 col-smart-6"><img src="captcha/?PHPSESSID={$smarty.cookies.PHPSESSID}" class="captcha" alt="captcha"/></div>
			<div class="col-swga-6 col-smart-6">
				{if $error == 'captcha'}<label><span class="red-text">Капча введена неверно</span></label>{/if}
				<input type="text" name="captcha_code" class="control full" placeholder="Капча...">
				<input type="submit" name="feedback" class="btn btn-blue full" value="Отправить">
			</div>
		</div>
	</form>

	{/if}


</div>



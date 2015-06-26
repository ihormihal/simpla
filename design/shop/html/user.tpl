{* Шаблон страницы зарегистрированного пользователя *}

{$pagetitle = $user->name|escape}
{$meta_title = $user->name|escape scope=parent}

{$crumbs = ['Главная'=>'./']}
{include file='view/base/pre-header.tpl'}
   
<div class="container content">
	
	<div class="row gaprow">
		
		<div class="col-htab-4">
			<h2 class="title upper orange-text-light mb0"><i class="fa fa fa-pencil"></i>Ваш профиль</h2>
			<form method="post">
				{if $error == 'user_exists'}
				<label class="center"><span class="red-text"><i class="fa fa-exclamation-circle"></i> Пользователь с таким email уже зарегистрирован</span></label>
				{/if}
				<br>
				<label>Имя* {if $error == 'empty_name'}<span class="red-text">Введите имя</span>{/if}</label>
				<input type="text" class="control full" name="name" value="{$name|escape}" required>
				<label>E-mail* {if $error == 'empty_email'}<span class="red-text">Введите e-mail</span>{/if}</label>
				<input type="email" class="control full" name="email" value="{$email|escape}" required>
				<label>Пароль* {if $error == 'empty_password'}<span class="red-text">Введите пароль</span>{/if}</label>
				<input type="password" class="control full" name="password">

				<input type="submit" name="register" class="btn btn-blue full" value="Сохранить">
			</form>
		</div>
		<div class="col-htab-8">
			<h2 class="title upper orange-text-light mb0"><i class="fa fa fa-history"></i>Ваши заказы</h2>
			<div class="gap"></div>
			<div class="box">
				{if $orders}
				<table class="orders">
					{foreach name=orders item=order from=$orders}
					<tr>
						<td class="time"><i class="fa fa-calendar"></i><span>{$order->date|date}</span><i class="fa fa-clock-o"></i><span>{$order->date|time}</span></td>
						<td><a class="blue-text link" href='order/{$order->url}'>Заказ №{$order->id}</a></td>
						<td>
						{if $order->paid == 1}оплачен{/if} 
						{if $order->status == 0}
							<span class="grey-text status">ждет обработки</span>
						{elseif $order->status == 1}
							<span class="orange-text status">в обработке</span>
						{elseif $order->status == 2}
							<span class="green-text status">выполнен</span>
						{/if}
						</td>
					</tr>
					{/foreach}
				</table>
				{else}
				<p>Нет заказов</p>
				{/if}
			</div>
		</div>
	</div>	

</div>
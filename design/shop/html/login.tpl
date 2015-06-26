{* Страница входа пользователя *}
{* Канонический адрес страницы *}
{$canonical="/user/login" scope=parent}

{$pagetitle = "Вход"}
{$meta_title = "Вход" scope=parent}

{$crumbs = ['Главная'=>'./']}
{include file='view/base/pre-header.tpl'}
   
<div class="container content">

	<form method="post">
		<div class="row">
			<div class="col-htab-3"></div>
			<div class="col-htab-6">
				{if $error == 'login_incorrect'}
				<label class="center"><span class="red-text"><i class="fa fa-exclamation-circle"></i> Неверный логин или пароль</span></label>
				{elseif $error == 'user_disabled'}
				<label class="center"><span class="red-text"><i class="fa fa-exclamation-circle"></i> Ваш аккаунт еще не активирован</span></label>
				{else}{$error}{/if}
				<br>
				<label>E-mail*</label>
				<input type="email" class="control full" name="email" value="{$email|escape}" required>
				<label>Пароль*</label>
				<input type="password" class="control full" name="password" required>
				<input type="submit" name="login" class="btn btn-blue full" value="Войти">
			</div>
		</div>
	</form>

</div>

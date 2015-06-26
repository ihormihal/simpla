{* Страница регистрации *}
{* Канонический адрес страницы *}
{$canonical="/user/register" scope=parent}

{$pagetitle = "Регистрация"}
{$meta_title = "Регистрация" scope=parent}

{$crumbs = ['Главная'=>'./']}
{include file='view/base/pre-header.tpl'}
   
<div class="container content">

	<form method="post">
		<div class="row">
			<div class="col-htab-3"></div>
			<div class="col-htab-6">
				{if $error == 'user_exists'}
				<label class="center"><span class="red-text"><i class="fa fa-exclamation-circle"></i> Пользователь с таким email уже зарегистрирован</span></label>
				{/if}
				<br>
				<label>Имя* {if $error == 'empty_name'}<span class="red-text">Введите имя</span>{/if}</label>
				<input type="text" class="control full" name="name" value="{$name|escape}" required>
				<label>E-mail* {if $error == 'empty_email'}<span class="red-text">Введите e-mail</span>{/if}</label>
				<input type="email" class="control full" name="email" value="{$email|escape}" required>
				<label>Пароль* {if $error == 'empty_password'}<span class="red-text">Введите пароль</span>{/if}</label>
				<input type="password" class="control full" name="password" required>

				<div class="row">
					<div class="col-swga-6 col-smart-6"><img src="captcha/?PHPSESSID={$smarty.cookies.PHPSESSID}" class="captcha" alt="captcha"/></div>
					<div class="col-swga-6 col-smart-6">
						{if $error == 'captcha'}<label><span class="red-text">Капча введена неверно</span></label>{/if}
						<input type="text" name="captcha_code" class="control full" placeholder="Капча...">
					</div>
				</div>

				<input type="submit" name="register" class="btn btn-blue full" value="Зарегистрироваться">
			</div>
		</div>
	</form>

</div>
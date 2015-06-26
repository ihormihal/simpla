<form method="post" action="{$smarty.server.REQUEST_URI}" id="ajax-comment-form">
	<input type="hidden" name="comment" value="1">
	<label>Ваше имя* {if $error=='empty_name'}<span class="red-text">Введите Имя</span>{/if}</label>
	<input type="text" name="name" class="control full" value="{$comment->name}">
	<label>Ваш email* {if $error=='empty_email'}<span class="red-text">Введите E-mail</span>{/if}</label>
	<input type="email" name="email" class="control full" value="{$comment->email}">
	<label>Комментарий* {if $error=='empty_comment'}<span class="red-text">Введите текст коментария</span>{/if}</label>
	<textarea name="text" class="control full" rows="5">{$comment->text}</textarea>
	<div class="row">
		<div class="col-swga-6 col-smart-6"><img src="captcha/?PHPSESSID={$smarty.cookies.PHPSESSID}" class="captcha" alt="captcha"/></div>
		<div class="col-swga-6 col-smart-6">
			{if $error == 'captcha'}<label><span class="red-text">Капча введена неверно</span></label>{/if}
			<input type="text" name="captcha_code" class="control full" placeholder="Капча...">
			<input type="submit" name="" class="btn btn-blue full" value="Отправить" onclick="ga('send', 'event', 'Комментарий', 'Нажатие');">
		</div>
	</div>
</form>

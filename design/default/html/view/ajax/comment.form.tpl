<!--Форма отправления комментария-->	
<form class="comment_form" method="post" action="{$smarty.server.REQUEST_URI}" id="ajax-comment-form">
	<input type="hidden" name="comment" value="1">
	<h2>Написать комментарий</h2>
	{if $error}
	<div class="message_error">
		{if $error=='captcha'}
		Неверно введена капча
		{elseif $error=='empty_name'}
		Введите имя
		{elseif $error=='empty_email'}
		Введите e-mail
		{elseif $error=='empty_comment'}
		Введите комментарий
		{/if}
	</div>
	{/if}
	

	<label for="comment_name">Имя</label>
	<input type="text" id="comment_name" name="name" value="{$comment_name}"/>
	<br />
	<label for="comment_email">Email</label>
	<input type="text" id="comment_email" name="email" value="{$comment_email}"/>
	<br />
	<label for="comment_text">Комментарий</label>
	<textarea class="comment_textarea" id="comment_text" name="text" data-format=".+" data-notice="Введите комментарий">{$comment_text}</textarea><br />
	<br />
	<label for="comment_captcha">Число</label>

	<div class="captcha"><img src="captcha/image.php?{math equation='rand(10,10000)'}" alt='captcha'/></div> 
	<input class="input_captcha" id="comment_captcha" type="text" name="captcha_code" value="" data-format="\d\d\d\d" data-notice="Введите капчу"/>
	<br />
	<input class="button" type="submit" value="Отправить" />

</form>
<!--Форма отправления комментария (The End)-->
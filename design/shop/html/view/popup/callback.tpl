<div id="callback" class="popup">
	<form action="http://shop-gsm.net/ajax/fast-call.php" method="post">
		<input name="url" type="hidden" value="{$config->root_url}/{url}">
		<h3 class="title">Обратный звонок</h3>
		<label>Ваше имя</label>
		<input class="full control" type="text" name="name" placeholder="Ваше имя">
		<label>Ваш телефон</label>
		<input class="full control phone" type="text" name="phone" placeholder="(0XX) XXX-XX-XX">
		<input type="submit" class="btn btn-blue upper full" value="Заказать">
	</form>
</div>
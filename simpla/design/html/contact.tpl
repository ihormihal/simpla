{* Вкладки *}
{capture name=tabs}
	{if in_array('settings', $manager->permissions)}<li><a href="index.php?module=SettingsAdmin">Настройки</a></li>{/if}
	{if in_array('currency', $manager->permissions)}<li><a href="index.php?module=CurrencyAdmin">Валюты</a></li>{/if}
	{if in_array('currency', $manager->permissions)}<li><a href="index.php?module=DeliveriesAdmin">Доставка</a></li>{/if}
	{if in_array('payment', $manager->permissions)}<li><a href="index.php?module=PaymentMethodsAdmin">Оплата</a></li>{/if}
	{if in_array('managers', $manager->permissions)}<li><a href="index.php?module=ManagersAdmin">Менеджеры</a></li>{/if}
	<li class="active"><a href="index.php?module=ContactsAdmin">Контакты</a></li>
{/capture}

{if $place->id}
{$meta_title = $place->title scope=parent}
{else}
{$meta_title = 'Новый способ доставки' scope=parent}
{/if}

{* Подключаем Tiny MCE *}
{include file='tinymce_init.tpl'}

{* On document load *}
{literal}
<script src="design/js/jquery/jquery.js"></script>
<script src="design/js/jquery/jquery-ui.min.js"></script>

<script>
$(function() {

$('select[name=module]').change(function(){
	$('div#module_settings').hide();
	$('div#module_settings[module='+$(this).val()+']').show();
	});
});


</script>


{/literal}



{if $message_success}
<!-- Системное сообщение -->
<div class="message message_success">
	<span class="text">{if $message_success == 'added'}Магазин добавлен{elseif $message_success == 'updated'}Магазин изменен{/if}</span>
	{if $smarty.get.return}
	<a class="button" href="{$smarty.get.return}">Вернуться</a>
	{/if}
</div>
<!-- Системное сообщение (The End)-->
{/if}

{if $message_error}
<!-- Системное сообщение -->
<div class="message message_error">
	<span class="text">{$message_error}</span>
	<a class="button" href="">Вернуться</a>
</div>
<!-- Системное сообщение (The End)-->
{/if}

<!-- Основная форма -->
<form method=post id=product enctype="multipart/form-data">
	<input type=hidden name="session_id" value="{$smarty.session.id}">
	<input name=id type="hidden" value="{$place->id}"/> 


	<!-- Левая колонка свойств товара -->
	<div id="column_left">
		<!-- Параметры -->
		<div class="block">
			<h2>Настройки объекта</h2>
			<ul>
				<li><label class=property>Название</label><input name="title" class="simpla_inp" type="text" value="{$place->title|escape}" /></li>
				<li><label class=property>Город</label><input name="city" class="simpla_inp" type="text" value="{$place->city|escape}" /></li>
				<li><label class=property>Адрес</label><input name="address" class="simpla_inp" type="text" value="{$place->address|escape}" /></li>
				<li><label class=property>Кординаты (lat,lng,zoom)</label><input name="latlng" class="simpla_inp" type="text" value="{$place->latlng|escape}" /></li>
			</ul>
		</div>

		<!-- Параметры -->
		<div class="block">
			<h2>Контакты</h2>
			<ul>
				<li><label class=property>Тел.1</label><input name="phone[]" class="simpla_inp" type="text" value="{$phones[0]}" /></li>
				<li><label class=property>Тел.2</label><input name="phone[]" class="simpla_inp" type="text" value="{$phones[1]}" /></li>
				<li><label class=property>Тел.3</label><input name="phone[]" class="simpla_inp" type="text" value="{$phones[2]}" /></li>
				<li><label class=property>Тел.4</label><input name="phone[]" class="simpla_inp" type="text" value="{$phones[3]}" /></li>
				<li><label class=property>Тел.5</label><input name="phone[]" class="simpla_inp" type="text" value="{$phones[4]}" /></li>
				<li><label class=property>Тел.6</label><input name="phone[]" class="simpla_inp" type="text" value="{$phones[5]}" /></li>
			</ul>
		</div>

	</div>
	<!-- Левая колонка свойств товара (The End)--> 
	
	<!-- Левая колонка свойств товара -->
	<div id="column_right">
		<!-- Параметры -->
		<div class="block">
			<h2>E-mail, Skype</h2>
			<ul>
				<li><label class=property>E-mail</label><input name="email" class="simpla_inp" type="text" value="{$place->email}" /></li>
				<li><label class=property>Skype</label><input name="skype" class="simpla_inp" type="text" value="{$place->skype}" /></li>
			</ul>
		</div>

		<input name=enabled value='1' type="checkbox" id="active_checkbox" {if $place->enabled}checked{/if}/> <label for="active_checkbox">Активен</label>
		<p style="height: 20px;"></p>
		<!-- Параметры -->
		<div class="block">
			<h2>Время работы</h2>
			<ul>
				<li><label class=property>Пн</label><input name="schedule[]" class="simpla_inp" type="text" value="{$schedule[0]}" /></li>
				<li><label class=property>Вт</label><input name="schedule[]" class="simpla_inp" type="text" value="{$schedule[1]}" /></li>
				<li><label class=property>Ср</label><input name="schedule[]" class="simpla_inp" type="text" value="{$schedule[2]}" /></li>
				<li><label class=property>Чт</label><input name="schedule[]" class="simpla_inp" type="text" value="{$schedule[3]}" /></li>
				<li><label class=property>Пт</label><input name="schedule[]" class="simpla_inp" type="text" value="{$schedule[4]}" /></li>
				<li><label class=property>Сб</label><input name="schedule[]" class="simpla_inp" type="text" value="{$schedule[5]}" /></li>
				<li><label class=property>Вс</label><input name="schedule[]" class="simpla_inp" type="text" value="{$schedule[6]}" /></li>
			</ul>
		</div>
	</div>
	<!-- Левая колонка свойств товара (The End)--> 
	
	<!-- Описагние товара -->
	<div class="block layer">
		<h2>Описание</h2>
		<textarea name="description" class="editor_small">{$place->description|escape}</textarea>
	</div>
	<!-- Описание товара (The End)-->
	<input class="button_green button_save" type="submit" name="" value="Сохранить" />
	
</form>
<!-- Основная форма (The End) -->


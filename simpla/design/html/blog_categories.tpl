{* Вкладки *}
{capture name=tabs}
	<li><a href="index.php?module=BlogAdmin">Блог</a></li>
	<li class="active"><a href="index.php?module=BlogCategoriesAdmin">Категории блога</a></li>
{/capture}

{* Title *}
{$meta_title='Блог' scope=parent}
		
{* Заголовок *}
<div id="header">
	{if $categories|count > 0}
	<h1>Категории блога</h1>
	{else}
	<h1>Нет категорий</h1>
	{/if}
	<a class="add" href="{url module=BlogCategoryAdmin return=$smarty.server.REQUEST_URI}">Добавить категорию</a>
</div>	

{if $categories}
<div id="main_list">
	
	<!-- Листалка страниц -->
	{include file='pagination.tpl'}	
	<!-- Листалка страниц (The End) -->

	<form id="form_list" method="post">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	
		<div id="list">
			{foreach $categories as $category}
			<div class="row">
		 		<div class="checkbox cell">
					<input type="checkbox" name="check[]" value="{$category->id}" />				
				</div>
				<div class="name cell">		
					<a href="{url module=BlogCategoryAdmin id=$category->id return=$smarty.server.REQUEST_URI}">{$category->name|escape}</a>
				</div>
				<div class="icons cell">
					<a class="preview" title="Предпросмотр в новом окне" href="../blog/?category={$category->id}" target="_blank"></a>
					<a class="delete" title="Удалить" href="#"></a>
				</div>
				<div class="clear"></div>
			</div>
			{/foreach}
		</div>
		
	
		<div id="action">
		<label id="check_all" class="dash_link">Выбрать все</label>
	
		<span id="select">
		<select name="action">
			<option value="delete">Удалить</option>
		</select>
		</span>
	
		<input id="apply_action" class="button_green" type="submit" value="Применить">
		
		</div>
				
	</form>	

	<!-- Листалка страниц -->
	{include file='pagination.tpl'}	
	<!-- Листалка страниц (The End) -->
	
</div>
{/if}

{* On document load *}
{literal}

<script>
$(function() {

	// Раскраска строк
	function colorize()
	{
		$("#list div.row:even").addClass('even');
		$("#list div.row:odd").removeClass('even');
	}
	// Раскрасить строки сразу
	colorize();

	// Выделить все
	$("#check_all").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', $('#list input[type="checkbox"][name*="check"]:not(:checked)').length>0);
	});	

	// Удалить 
	$("a.delete").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', false);
		$(this).closest(".row").find('input[type="checkbox"][name*="check"]').attr('checked', true);
		$(this).closest("form").find('select[name="action"] option[value=delete]').attr('selected', true);
		$(this).closest("form").submit();
	});
	
	// Подтверждение удаления
	$("form").submit(function() {
		if($('select[name="action"]').val()=='delete' && !confirm('Подтвердите удаление'))
			return false;	
	});
});

</script>
{/literal}
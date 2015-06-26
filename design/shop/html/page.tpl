{* Шаблон текстовой страницы *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}


{$pagetitle = $page->header|escape}

{$crumbs = ['Главная'=>'./']}
{include file='view/base/pre-header.tpl'}

<div class="container content" data-page="{$page->id}">
	{$page->body}
</div>
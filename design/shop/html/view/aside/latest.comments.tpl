{* Рекурсивная функция вывода дерева комментариев *}
{get_comments var=latest_comments parent=0 limit=5}

<h2 class="title upper">Последние комментарии</h2>
<div class="comments">
{if $latest_comments}
	<ul>
	{foreach $latest_comments as $latest_comment}
		{* Показываем только одобренные *}
		{if $latest_comment->approved}
			<li>
				{$latest_comment->text|escape|nl2br}
			</li>
		{/if}
	{/foreach}
	</ul>
{/if}
</div>

{* Рекурсивная функция вывода дерева комментариев *}
{get_comments var=latest_comments parent=0 limit=5}

{function name=latest_comments_tree}
	{if $latest_comments}
		<ul>
		{foreach $latest_comments as $latest_comment}
			{* Показываем только одобренные *}
			{if $latest_comment->approved}
				<li>
					{$latest_comment->text|escape|nl2br}
					{latest_comments_tree latest_comments=$latest_comment->children}
				</li>
			{/if}
		{/foreach}
		</ul>
	{/if}
{/function}
{latest_comments_tree latest_comments=$latest_comments}
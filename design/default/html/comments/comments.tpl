{* Рекурсивная функция вывода дерева комментариев *}
{function name=comments_tree}
	{if $comments}
		<ul class="comment_list">
		{foreach $comments as $comment}
			{* Показываем только одобренные *}
			{if $comment->approved}
				<li class="comment {if $comment->admin}admin{/if}">
					<div class="comment_header">	
						{$comment->name|escape} <i>{$comment->date|date}, {$comment->date|time}</i>
					</div>
					{$comment->text|escape|nl2br}
					<div class="actions">
						<a class="comment-answer" data-form="#comment-answer-{$comment->id}" href="ajax/comment.form.php?parent={$comment->id}&type=product&object_id={$product->id}">Ответить</a>
					</div>
					<a href="ajax/comment.rate.php?id={$comment->id}&rate=up" class="rate-comment rate-comment-up">Лайк (<span>{$comment->rate_up}</span>)</a>
					<a href="ajax/comment.rate.php?id={$comment->id}&rate=down" class="rate-comment rate-comment-up">Дислайк (<span>{$comment->rate_down}</span>)</a>
					<ul class="comment_list" id="comment-answer-{$comment->id}"></ul>
					{comments_tree comments=$comment->children}
				</li>
			{/if}
		{/foreach}
		</ul>
	{else}
	<ul class="comment_list"></ul>
	{/if}
{/function}
{comments_tree comments=$comments}
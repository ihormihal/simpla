<li class="comment {if $comment->admin}admin{/if}">
	<div class="comment_header">	
		{$comment->name|escape} <i>{$comment->date|date}, {$comment->date|time}</i>
	</div>
	{if $comment->approved}
	{$comment->text|escape|nl2br}
	{else}
	Ваш комментарий будет доступен для просмотра после одобрения администратором
	{/if}
	<div class="actions">
		<a class="comment-answer" data-form="#comment-answer-{$comment->id}" href="ajax/comment.form.php?parent={$comment->id}&type={$comment->type}&object_id={$comment->object_id}">Ответить</a>
		<a href="ajax/comment.rate.php?id={$comment->id}&rate=up" class="rate-comment rate-comment-up">Лайк (<span>{$comment->rate_up}</span>)</a>
		<a href="ajax/comment.rate.php?id={$comment->id}&rate=down" class="rate-comment rate-comment-up">Дислайк (<span>{$comment->rate_down}</span>)</a>
	</div>
	<div id="comment-answer-{$comment->id}"></div>
</li>
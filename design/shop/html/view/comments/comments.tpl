<div id="comments">
{* Рекурсивная функция вывода дерева комментариев *}
{function name=comments_tree}
	{if $comments}
		{if $product}<span class="hidden" itemprop="itemReviewed">{$product->name|escape}</span>{/if}
		<ul class="ul comments">
		{foreach $comments as $comment}
			{* Показываем только одобренные *}
			{if $comment->approved}
				<li class="comment {if $comment->admin}admin{/if}">
					<div class="head">
						<span class="name" itemprop="author"><i class="fa fa-user"></i><span>{$comment->name|escape}</span></span>
						<span class="date"><i class="fa fa-calendar"></i><time datePublished="{$comment->date}" content="{$comment->date|date:"Y-m-d"}">{$comment->date|date}, {$comment->date|time}</time></span>
					</div>
					<div class="text" itemprop="reviewBody">{$comment->text|escape|nl2br}</div>
					<div class="foot">
						<a data-form="#comment-answer-{$comment->id}" href="ajax/comment.form.php?parent={$comment->id}&type={$comment->type}&object_id={$comment->object_id}" class="dotted comment-answer">ответить</a>
						<span class="comment-rate">
							Полезен отзыв? 
							<a href="ajax/comment.rate.php?id={$comment->id}&rate=up" class="rate-comment true"><i class="fa fa-thumbs-o-up"></i> (<span>{$comment->rate_up}</span>)</a>
							<a href="ajax/comment.rate.php?id={$comment->id}&rate=down" class="rate-comment false"><i class="fa fa-thumbs-o-down"></i> (<span>{$comment->rate_down}</span>)</a>
						</span>
					</div>
					<ul class="ul comments" id="comment-answer-{$comment->id}"></ul>
					{comments_tree comments=$comment->children}
					{$child=1}
				</li>
			{/if}
		{/foreach}
		</ul>
	{/if}
{/function}
{comments_tree comments=$comments}
{if !$comments}<ul class="ul comments"><small>Пока что комментариев нет. Будьте первыми!</small></ul>{/if}
</div>
<li class="comment {if $comment->admin}admin{/if}">
	<div class="head">
		<span class="name"><i class="fa fa-user"></i><span>{$comment->name|escape}</span></span>
		<span class="date"><i class="fa fa-calendar"></i><time>{$comment->date|date}, {$comment->date|time}</time></span>
	</div>
	<div class="text">{$comment->text|escape|nl2br}</div>
	<div class="foot">
		<a data-form="#comment-answer-{$comment->id}" href="ajax/comment.form.php?parent={$comment->id}&type=product&object_id={$product->id}" class="dotted comment-answer">ответить</a>
		<span class="comment-rate">
			Полезен отзыв? 
			<a href="ajax/comment.rate.php?id={$comment->id}&rate=up" class="rate-comment true"><i class="fa fa-thumbs-o-up"></i> (<span>{$comment->rate_up}</span>)</a>
			<a href="ajax/comment.rate.php?id={$comment->id}&rate=down" class="rate-comment false"><i class="fa fa-thumbs-o-down"></i> (<span>{$comment->rate_down}</span>)</a>
		</span>
	</div>
	<ul class="ul" id="comment-answer-{$comment->id}"></ul>
</li>
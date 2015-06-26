{function name=comments_tree}
	{foreach $comments as $comment}
		<div class="{if !$comment->approved}unapproved{/if} {if $comment->admin}admin-comment{/if} row">
			<div class="checkbox cell"><input type="checkbox" name="check[]" value="{$comment->id}"/></div>

			<div class="name cell">
				<div class="comment_name">
				{$comment->name|escape}
				<a class="approve" href="#">Одобрить</a>
				</div>
				<div class="comment_text">
				{$comment->text|escape|nl2br}
				</div>
				<div class="comment_info">
				Комментарий (id = {$comment->id}) оставлен {$comment->date|date} в {$comment->date|time}
				{if $comment->parent}
					(ответ на коментарий id = {$comment->parent})
				{else}
					{if $comment->type == 'product'}
					к товару <a target="_blank" href="{$config->root_url}/products/{$comment->product->url}#comment_{$comment->id}">{$comment->product->name}</a>
					{elseif $comment->type == 'blog'}
					к статье <a target="_blank" href="{$config->root_url}/blog/{$comment->post->url}#comment_{$comment->id}">{$comment->post->name}</a>
					{/if}
				{/if}
				</div>

				<div class="cell-actions">
					<a class="edit" href="{url module=CommentEditAdmin id=$comment->id return=$smarty.server.REQUEST_URI}">Редактировать</a>
					{if $comment->email}
					<a class="answer" href="{url module=CommentAdmin id=$comment->id return=$smarty.server.REQUEST_URI}">Ответить</a>
					{/if}
				</div>
			</div>


			<div class="icons cell"><a class="delete" title="Удалить" href="#"></a></div>
			<div class="clear"></div>
		</div>
		{comments_tree comments=$comment->children}
	{/foreach}
{/function}
{comments_tree comments=$comments}
{$subject="Ответ Администратора на Ваш комментарий scope=parent}
<h1>{$user_comment->name|escape}, вам пришел ответ на Ваш комментарий к</h1>
{if $comment->type == 'product'}<a target="_blank" href="{$config->root_url}/products/{$comment->product->url}#comment_{$comment->id}">{$comment->product->name}</a>{/if}
{if $comment->type == 'blog'}<a target="_blank" href="{$config->root_url}/blog/{$comment->post->url}#comment_{$comment->id}">{$comment->post->name}</a>{/if}

<h2>Вы писали ({$user_comment->date|date} {$user_comment->date|time}):</h2>
<div>
  <i>{$user_comment->text|escape|nl2br}</i>
</div>
<h2>Ответ ({$comment->date|date} {$comment->date|time}):</h2>
<div>
   {$comment->text|escape|nl2br}
</div>
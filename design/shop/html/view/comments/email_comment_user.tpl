{$subject="Ответ Администратора на Ваш комментарий" scope=parent}
<h1>{$user_comment->name|escape}, Вам пришел ответ на Ваш комментарий</h1>
{if $user_comment->type == 'product'}
<a target="_blank" href="{$config->root_url}/products/{$user_comment->product->url}#comment_{$comment->id}">{$user_comment->product->name}</a>
{else}
<a target="_blank" href="{$config->root_url}/blog/{$user_comment->post->url}#comment_{$comment->id}">{$user_comment->post->name}</a>
{/if}

<h2>Вы писали ({$user_comment->date|date} {$user_comment->date|time}):</h2>
<div>
  <i>{$user_comment->text|escape|nl2br}</i>
</div>
<h2>Ответ ({$comment->date|date} {$comment->date|time}):</h2>
<div>
   {$comment->text|escape|nl2br}
</div>
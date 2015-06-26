<!-- Меню блога -->
{* Выбираем в переменную $last_posts последние записи *}
{get_posts var=last_posts limit=5}
{if $last_posts}
<div id="blog_menu">
	<h2>Новые записи в <a href="blog">блоге</a></h2>
	{foreach $last_posts as $post}
	<ul>
		<li data-post="{$post->id}">{$post->date|date} <a href="blog/{$post->url}">{$post->name|escape}</a></li>
	</ul>
	{/foreach}
</div>
{/if}
<!-- Меню блога  (The End) -->
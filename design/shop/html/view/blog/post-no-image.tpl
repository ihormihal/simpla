<article class="post">
	<h2 class="title"><a href="blog/{$post->url}" data-post="{$post->id}">{$post->name|escape}</a></h2>
	<div class="meta">
		<span class="date"><i class="fa fa-calendar"></i><time>{$post->date|date}</time></span>
		<span class="right"><i class="fa fa-comments-o"></i> {$post->comments_count}</span>
	</div>
	<div class="introtext">
		{$post->annotation}
	</div>
	<a href="blog/{$post->url}" class="btn btn-border upper">Подробнее</a>
</article>
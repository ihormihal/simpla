<h2 class="title upper">Наши новости</h2>
<div class="news">
	{get_posts var=last_posts limit=5}
	{if $last_posts}
	<ul class="ul">
		{foreach $last_posts as $post}
		<li>
			<div class="image">
				<a href="blog/{$post->url}">
					<img src="{if $post->image}{$config->root_url}/{$config->pages_images_dir}{$post->image}{else}design/{$settings->theme|escape}/images/no-image.png{/if}" alt="{$post->name|escape}">
				</a>
			</div>
			<div class="content">
				<div class="title"><a href="blog/{$post->url}">{$post->name|escape}</a></div>
				<div class="date"><i class="fa fa-calendar"></i><time pubdate="{$post->date|date}">{$post->date|date:"d M Y"}</time></div>
			</div>
		</li>
		{/foreach}
	</ul>
	{/if}
</div>
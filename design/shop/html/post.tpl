{$pagetitle = $post->name|escape}
{$description = $post->annotation|escape}
{* Канонический адрес страницы *}
{$canonical="/blog/{$post->url}" scope=parent}

{$crumbs = ['Главная'=>'./','Блог'=>'blog/']}

{include file='view/base/pre-header.tpl'}

<div class="container content">
	<div class="row">
		<div class="col-swga-9 col-htab-8">
			<article class="post post-single" itemscope itemType="http://schema.org/BlogPosting">
				<span class="hidden" itemprop="headline">{$post->name|escape}</span>
				<div class="meta">
					<meta itemprop="datePublished" content="{$post->date|date:"Y-m-d"}" itemprop="datePublished" content="2011-06-02T16:00Z"/>
					<span class="date"><i class="fa fa-calendar"></i><time>{$post->date|date}</time></span>
					<span class="right"><i class="fa fa-comments-o"></i> 7</span>
				</div>
				{if $post->image}
				<div class="image">
					<a href="#"><img src="{$config->root_url}/{$config->pages_images_dir}{$post->image}" alt=""></a>
				</div>
				{/if}
				<div class="content" itemprop="articleBody" data-post="{$post->id}">
					{$post->text}
				</div>
				<div class="clear"></div>
				<div class="tags">
					<span>Теги:</span>
					{foreach $tags as $tag}
						<a class="tag" href="blog/?keyword={$tag}">{$tag}</a>
					{/foreach}
				</div>
			</article>

			<div class="gap"></div>

			<div class="neighbors-pagination text-center">
				<div class="row">
					<div class="col-htab-6">{if $prev_post}<a href="blog/{$prev_post->url}"><i class="fa fa-angle-left"></i>{$prev_post->name}</a>{/if}</div>
					<div class="col-htab-6">{if $next_post}<a href="blog/{$next_post->url}">{$next_post->name}<i class="fa fa-angle-right"></i></a>{/if}</div>
				</div>
			</div>
			<div class="gap"></div>

			<h3 class="title upper orange-text"><i class="fa fa-pencil"></i> Ваш комментарий</h3>
			<div class="ajax-content" data-url="ajax/comment.form.php?parent=0&type=blog&object_id={$post->id}"></div>

			<div class="gap"></div>
			<h3 class="title upper orange-text"><i class="fa fa-comments-o"></i> Комментарии</h3>
			{include file="view/comments/comments.tpl"}

		</div>
		<div class="col-swga-3 col-htab-4">
			<aside>
				<h2 class="title upper">Категории</h2>
				<ul class="ul nav">
					<li {if $post->category == 0}class="active"{/if}><a href="blog/"><i class="fa fa-angle-right"></i>Все новости</a></li>
					{foreach $blog_categories as $bc}
					<li {if $bc->id == $post->category}class="active"{/if}><a href="blog/{$bc->url}/"><i class="fa fa-angle-right"></i>{$bc->name}</a></li>
					{/foreach}
				</ul>
			</aside>
		</div>
	</div>
</div>
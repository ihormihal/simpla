{$crumbs = ['Главная'=>'./']}
{if $cat}
	{$crumbs['Блог'] = 'blog/'}
{/if}

{include file='view/base/pre-header.tpl'}
<div class="container content">
	<div class="row">
		<div class="col-swga-9 col-htab-8">
			<div class="gap"></div>
			<div class="blog">
				{if $posts}
				{foreach $posts as $post}

					{if $post->image}
						{include file='view/blog/post.tpl'}
					{else}
						{include file='view/blog/post-no-image.tpl'}
					{/if}

				{/foreach}
				{else}
				Новостей нет
				{/if}
			</div>
			{include file='view/base/blog-pagination.tpl'}
		</div>
		<div class="col-swga-3 col-htab-4">
			<aside>
				<h2 class="title upper">Категории</h2>
				<ul class="ul nav">
					<li {if !$cat}class="active"{/if}><a href="blog/"><i class="fa fa-angle-right"></i>Все новости</a></li>
					{foreach $blog_categories as $bc}
					<li {if $bc->id == $cat->id}class="active"{/if}><a href="blog/{$bc->url}/"><i class="fa fa-angle-right"></i>{$bc->name}</a></li>
					{/foreach}
				</ul>
			</aside>
		</div>
	</div>
</div>
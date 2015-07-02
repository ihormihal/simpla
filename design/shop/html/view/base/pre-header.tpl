<div class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-swga-6">
				<h1>{$pagetitle}</h1>
			</div>
			<div class="col-swga-6">
				<ul class="ul breadcrumbs" itemscope itemtype="http://schema.org/BreadcrumbList">
					{foreach $crumbs as $crumb => $link}
					<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"><a href="{$link}" itemprop="name">{$crumb}</a></li>
					{/foreach}
					<li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"><span itemprop="name">{$pagetitle}</span></li>
				</ul>
			</div>
		</div>
	</div>
</div>


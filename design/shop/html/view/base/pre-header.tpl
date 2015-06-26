<div class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-swga-6">
				<h1>{$pagetitle}</h1>
			</div>
			<div class="col-swga-6">
				<ul class="ul breadcrumbs">
					{foreach $crumbs as $crumb => $link}
					<li><a href="{$link}">{$crumb}</a></li>
					{/foreach}
					<li><span>{$pagetitle}</span></li>
				</ul>
			</div>
		</div>
	</div>
</div>


<div class="container content">
	<div class="row">
		
		<div class="col-swga-9 col-htab-8">

			{get_featured_products var=featured_products}
			{if $featured_products}

			<div class="products">
				<h2 class="title upper orange-text-light mb0"><i class="fa fa-thumbs-o-up"></i>Рекомендуемые товары</h2>
				<div class="row">
				{foreach $featured_products as $product}
					{include file="view/product/grid.product.tpl"}
				{/foreach}
				</div>
			</div>
			<div class="gap"></div>
			<div class="gap"></div>
			{/if}

			{get_discounted_products var=discounted_products limit=9}
			{if $discounted_products}
			<div class="products">
				<h2 class="title upper red-text"><i class="fa fa-tags"></i>Акционные товары</h2>
				<div class="row">
					{foreach $discounted_products as $product}
					{include file="view/product/grid.product.tpl"}
					{/foreach}
				</div>
			</div>
			{/if}

		</div>
		<div class="col-swga-3 col-htab-4">
			<aside>

				{include file="view/aside/recently.viewed.tpl"}
				<div class="gap"></div>
				{include file="view/aside/brands.tpl"}
				<div class="gap"></div>
				{include file="view/aside/news.tpl"}
				<div class="gap"></div>
				{*include file="view/aside/latest.comments.tpl"*}
			</aside>
		</div>
	</div>
</div>
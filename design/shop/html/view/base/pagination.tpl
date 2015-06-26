<div class="pagination">
	<ul class="ul">
	{if $total_pages_num > 1}

		{if $current_page_num != 1}
		<li><a href="{$current_page_num-1}"><i class="fa fa-angle-left"></i></a></li>
		{else}
		<li><span><i class="fa fa-angle-left"></i></span></li>
		{/if}

		{for $page=1 to $total_pages_num}
			<li class="{if $page == $current_page_num}active{/if}"><a href="{$page}">{$page}</a></li>
		{/for}

		{if $current_page_num<$total_pages_num}
		<li><a href="{$current_page_num+1}"><i class="fa fa-angle-right"></i></a></li>
		{else}
		<li><span><i class="fa fa-angle-right"></i></span></li>
		{/if}

	{/if}
	</ul>
</div>
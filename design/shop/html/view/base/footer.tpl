<footer>
	<div class="footer-wrapper">
		<div class="container">
			<div class="row gaprow">
				<div class="col-swga-3">
					<div class="image footer-logo">
						<img src="design/{$settings->theme|escape}/images/logo-footer.png" alt="logo">
					</div>
				</div>
				<div class="col-swga-3 col-htab-6">
					<ul class="ul footer-nav">
						{foreach $pages as $p}
						{if $p->menu_id == 1}
						<li {if $page && $page->id == $p->id}class="active"{/if}><a href="{$p->url}"><i class="fa {$p->icon|escape}"></i>{$p->name|escape}</a></li>
						{/if}
						{/foreach}
					</ul>
				</div>
				<div class="col-swga-3 col-htab-6">
				<ul class="ul phone-list">
					{foreach $places as $place}
					<li>
						<i class="fa fa-phone"></i><span class="city">{$place->city}</span>
						<span class="code">{$place->phones[0]['code']}</span><span class="phone">{$place->phones[0]['number']}</span>
					</li>
					{/foreach}
				</ul>
				</div>
				<div class="col-swga-3">
					<div class="social center footer-social">
						<ul class="ul">
							<li class="facebook">
								<a rel="nofollow" href="http://www.facebook.com/shopgsm" target="_blank"><i class="fa fa-facebook"></i></a>
							</li>
							<li class="vk">
								<a rel="nofollow" href="http://vk.com/shopgsmnet" target="_blank"><i class="fa fa-vk"></i></a>
							</li>
							<li class="twitter">
								<a rel="nofollow" href="http://twitter.com/shopgsm" target="_blank"><i class="fa fa-twitter"></i></a>
							</li>
							<li class="google">
								<a rel="nofollow" href="https://plus.google.com/118108612153814981947/posts" target="_blank"><i class="fa fa-google-plus"></i></a>
							</li>
							<li class="youtube">
								<a rel="nofollow" href="http://www.youtube.com/shopgsmvideo" target="_blank"><i class="fa fa-youtube"></i></a>
							</li>
						</ul>
					</div>
					<div class="cards center">
						<span class="card"><img src="design/{$settings->theme|escape}/img/master_card.png" alt=""></span>
						<span class="card"><img src="design/{$settings->theme|escape}/img/visa_card.png" alt=""></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="copyright">
		<div class="container">
			2007-2015 &copy; Интернет-каталог SHOP-GSM
		</div>
	</div>
</footer>

{literal}
<script>
(function (i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] || function () {
        (i[r].q = i[r].q || []).push(arguments)
    }, i[r].l = 1 * new Date();
    a = s.createElement(o),
        m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

ga('create', 'UA-5012105-2', 'shop-gsm.net');
ga('require', 'displayfeatures');
ga('send', 'pageview');


</script>

<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-NK4L2H"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-NK4L2H');</script>
<!-- End Google Tag Manager -->

<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter10810246 = new Ya.Metrika({id:10810246,
                    webvisor:true,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true});
        } catch(e) { }
    });

    var n = d.getElementsByTagName("script")[0],
        s = d.createElement("script"),
        f = function () { n.parentNode.insertBefore(s, n); };
    s.type = "text/javascript";
    s.async = true;
    s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

    if (w.opera == "[object Opera]") {
        d.addEventListener("DOMContentLoaded", f, false);
    } else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/10810246" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->

<!-- BEGIN JIVOSITE CODE  -->
<script type='text/javascript'>
(function () {
    var widget_id = '11321';
    var s = document.createElement('script');
    s.type = 'text/javascript';
    s.async = true;
    s.src = '//code.jivosite.com/script/widget/' + widget_id;
    var ss = document.getElementsByTagName('script')[0];
    ss.parentNode.insertBefore(s, ss);
})();
</script>
<!-- END JIVOSITE CODE -->

<script type="text/javascript">
    var _cp = {trackerId: 12777};
    (function(d){
        var cp=d.createElement('script');cp.type='text/javascript';cp.async = true;
        cp.src='//tracker.cartprotector.com/cartprotector.js';
        var s=d.getElementsByTagName('script')[0]; s.parentNode.insertBefore(cp, s);
    })(document);
</script>


{/literal}
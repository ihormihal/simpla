<head>
	<base href="{$config->root_url}/"/>
	<title>{$meta_title|escape} | SHOP-GSM.NET</title>
	<link rel="shortcut icon" href="design/{$settings->theme|escape}/images/favicon.ico">

	{* Канонический адрес страницы *}
	{if isset($canonical)}<link rel="canonical" href="{$config->root_url}{$canonical}"/>{/if}

	{* Метатеги *}
	<meta http-equiv="Content-Type" content="text/html; charset=utf8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
	<meta name="description" content="{$meta_description|escape}">
	<meta name="author" content="SHOP-GSM">
	<meta name="keywords" content="{$meta_keywords|escape}" />

	{* Open Graph Protocol *}
	<meta property="og:title" content="{$meta_title|escape} | SHOP-GSM.NET" />
	<meta property="og:site_name" content="SHOP-GSM.NET" />
	<meta property="og:url" content="{$config->root_url}/{url}" />
	<meta property="og:description" content="{$meta_description|escape}" />
	{if $product}
	<meta property="og:type" content="product" />
	<meta property="og:image" content="{$product->images[0]->filename|resize:600:600}" />
	{/if}
	{if $post}
	<meta property="og:type" content="article" />
	{if $post->image}<meta property="og:image" content="{$config->root_url}/{$config->pages_images_dir}{$post->image}" />{/if}
	{/if}


	{* verification *}
	<meta name='yandex-verification' content='7a1b4c1ca9f826d6' />
	<meta name='yandex-verification' content='511a534f1247ba2c' />
	<meta name="google-site-verification" content="NIc-OHLjVWuxwjO1gGrQLTn8sTNPjc7XwyRlEPev5J4" />
	<meta name="wot-verification" content="b718e10db78a6351e4ec"/>
	<meta name="google-site-verification" content="OyKOzP4MasDFBuDaxw8scIcwo1mcVI2nv6jPn7sG7Bs" />
	<meta name="google-site-verification" content="ENYz-dVLGy_VnX7rCOTtGZvoxoW7keOQABji_OU7RpU" />
	{* IHOR M <meta name="google-site-verification" content="7NInkL0uNEyrYDM7rKyf4ZoYGtP_xhz8rNZsWjUJTBo" /> *}


	<link href='http://fonts.googleapis.com/css?family=Roboto:300,700,300italic,400&amp;subset=latin,cyrillic' rel='stylesheet' type='text/css'>

	<!-- Plugins CSS -->
	<link href="design/{$settings->theme|escape}/plugins/fancybox/css/jquery.fancybox.css" rel="stylesheet">
	<link href="design/{$settings->theme|escape}/plugins/owl-carousel/css/owl.carousel.css" rel="stylesheet">
	<link href="design/{$settings->theme|escape}/plugins/owl-carousel/css/owl.theme.css" rel="stylesheet">
	<link href="design/{$settings->theme|escape}/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link href="design/{$settings->theme|escape}/plugins/ion-range-slider/css/ion.rangeSlider.css" rel="stylesheet">
	<link href="design/{$settings->theme|escape}/plugins/ion-range-slider/css/ion.rangeSlider.skinBlue.css" rel="stylesheet">
	<link href="design/{$settings->theme|escape}/plugins/toast/jquery.toast.min.css" rel="stylesheet">
	<link href="design/{$settings->theme|escape}/css/animate.min.css" rel="stylesheet">

	<!-- Custom CSS -->
	<link rel="stylesheet" href="design/{$settings->theme|escape}/css/normalize.css">
	<link rel="stylesheet" href="design/{$settings->theme|escape}/css/grid.css">
	<link rel="stylesheet" href="design/{$settings->theme|escape}/css/style.css">

	{* PrivatBank *}
	<script id="privat_analytics" type="text/javascript" async src="https://socauth.privatbank.ua/cp/public/js/cp.js"></script>

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	{* google conversion *}
	<script type="text/javascript">
	/* <![CDATA[ */
	var google_conversion_id = 1041750609;
	var google_custom_params = window.google_tag_params;
	var google_remarketing_only = true;
	/* ]]> */
	</script>
	<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>

	{* takecallback *}
	<script charset="utf-8" src="http://takecallback.com.ua/code/js?id=103"></script>
</head>
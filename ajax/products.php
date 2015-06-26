<?PHP
if(!isset($_SESSION)){session_start();}
require_once('../api/Simpla.php');
//require_once('../api/Money.php');
$simpla = new Simpla();

// Валюты
$simpla->currencies = $simpla->money->get_currencies(array('enabled'=>1));
if(isset($_SESSION['currency_id']))
	$simpla->currency = $simpla->money->get_currency($_SESSION['currency_id']);
else
	$simpla->currency = reset($simpla->currencies);

$simpla->design->assign('currency',	$simpla->currency);

// GET-Параметры
$request_category = $simpla->request->get('category', 'array');
$request_brand = $simpla->request->get('brand','integer');
$request_sort = $simpla->request->get('sort', 'string');
$request_cost = explode(';',$simpla->request->get('cost'));
$request_features = $simpla->request->get('features');

$filter = array();
$filter['visible'] = 1;	


if ($request_category)
{
	$filter['category_id'] = json_decode($request_category, true);
	
}

if ($request_brand)
{
	$filter['brand_id'] = $request_brand;
}

$filter['minCost'] = 0;

$rate = 1/$simpla->money->convert(1);
$filter['minCost'] = round($request_cost[0]*$rate,2);
$filter['maxCost'] = round($request_cost[1]*$rate,2);

// Сортировка товаров, сохраняем в сесси, чтобы текущая сортировка оставалась для всего сайта
if($sort = $request_sort){
	$_SESSION['sort'] = $sort;		
}
if (!empty($_SESSION['sort'])){
	$filter['sort'] = $_SESSION['sort'];			
}
else{
	$filter['sort'] = 'position';			
}


// Свойства товаров
if($request_features){
	$features = array();
	foreach ($request_features as $feature_id => $value) {
		$features[$feature_id] = '"'.implode('","',$value).'"';
	}
	$filter['features'] = $features;
}


// Постраничная навигация
$items_per_page = $simpla->settings->products_num;		
// Текущая страница в постраничном выводе
$current_page = $simpla->request->get('page', 'int');	
// Если не задана, то равна 1
$current_page = max(1, $current_page);
$simpla->design->assign('current_page_num', $current_page);
// Вычисляем количество страниц
$products_count = $simpla->products->count_products($filter);

// Показать все страницы сразу
if($simpla->request->get('page') == 'all')
	$items_per_page = $products_count;	

$pages_num = ceil($products_count/$items_per_page);
$simpla->design->assign('total_pages_num', $pages_num);
$simpla->design->assign('total_products_num', $products_count);

$filter['page'] = $current_page;
$filter['limit'] = $items_per_page;


$discount = 0;
if(isset($_SESSION['user_id']) && $user = $simpla->users->get_user(intval($_SESSION['user_id']))){
	$discount = $user->discount;
}

// Товары 
$products = array();
foreach($simpla->products->get_products($filter) as $p){
	$products[$p->id] = $p;
}

if(!empty($products))
{
	$products_ids = array_keys($products);
	foreach($products as &$product)
	{
		$product->variants = array();
		$product->images = array();
		$product->properties = array();
	}

	$variants = $simpla->variants->get_variants(array('product_id'=>$products_ids, 'in_stock'=>true));
	
	foreach($variants as &$variant)
	{
		//$variant->price *= (100-$discount)/100;
		$products[$variant->product_id]->variants[] = $variant;
	}

	$images = $simpla->products->get_images(array('product_id'=>$products_ids));
	foreach($images as $image)
		$products[$image->product_id]->images[] = $image;

	foreach($products as &$product)
	{
		if(isset($product->variants[0]))
			$product->variant = $product->variants[0];
		if(isset($product->images[0]))
			$product->image = $product->images[0];
	}

	$simpla->design->assign('products', $products);
}


	
$output = $simpla->design->fetch('view/ajax/products.tpl');
echo $output;
return false;

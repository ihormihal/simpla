<?php
#return json of product by product id
header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");

if(!isset($_SESSION)){session_start();}
require_once('../api/Simpla.php');
$simpla = new Simpla();

// Валюты
$simpla->currencies = $simpla->money->get_currencies(array('enabled'=>1));
if(isset($_SESSION['currency_id']))
	$simpla->currency = $simpla->money->get_currency($_SESSION['currency_id']);
else
	$simpla->currency = reset($simpla->currencies);

$simpla->design->assign('currency',	$simpla->currency);

// GET-Параметры
$product_id = $simpla->request->get('id');

$product = $simpla->products->get_product($product_id);
if(!$product){
	return false;
}
$variants = array();
foreach($simpla->variants->get_variants(array('product_id'=>$product->id, 'in_stock'=>true)) as $v){
	$variants[$v->id] = $v;
}
$product->variants = $variants;
$images = $simpla->products->get_images(array('product_id'=>$product->id));
$product->image = $images[0]->filename;
$product->features = $simpla->features->get_product_options(array('product_id'=>$product->id));

echo json_encode($product);
return false;
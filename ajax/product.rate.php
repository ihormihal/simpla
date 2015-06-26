<?php
header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");

if(!isset($_SESSION)){session_start();}
require_once('../api/Simpla.php');
$simpla = new Simpla();



if($simpla->request->method('get') && $simpla->request->get('id') && $simpla->request->get('rate')){
	$id = (int)$simpla->request->get('id','int');
	$rate = (int)$simpla->request->get('rate','int');
	if($rate > 5){
		$rate = 5;
	}
	if(!isset($_SESSION['product_rate_ids'])) $_SESSION['product_rate_ids'] = array();

	$output = array('success' => 0, 'rate' => 0, 'votes' => 0, 'width' => '0%', 'message' => '');

	if(in_array($id, $_SESSION['product_rate_ids'])){
		$output['message'] = 'Вы уже голосовали за этот продукт!';
		echo json_encode($output);
		return false;
	}

	$product = $simpla->products->get_product($id);

	$product->rating = ($product->rating * $product->votes + $rate) / ($product->votes + 1);
	$product->votes = $product->votes + 1;

	$output['rate'] = round($product->rating, 1);
	$output['votes'] = $product->votes;
	$output['rate_width'] = ($product->rating * 20).'%';

	$simpla->products->update_product($product->id, $product);
	$_SESSION['product_rate_ids'][] = $product->id;
}

$output['success'] = 1;
echo json_encode($output);
return false;
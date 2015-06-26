<?php
header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");

if(!isset($_SESSION)){session_start();}
require_once('../api/Simpla.php');
$simpla = new Simpla();

$output = array('success' => 0, 'value' => 0, 'message' => '');
if ($simpla->request->method('get') && $simpla->request->get('id') && $simpla->request->get('rate')){
	$this_id = $simpla->request->get('id');

	if(!isset($_SESSION['comment_rate_ids'])) $_SESSION['comment_rate_ids'] = array();
	if(in_array($this_id, $_SESSION['comment_rate_ids'])) {
		$output['message'] = 'Вы уже голосовали за этот комментарий!';
		echo json_encode($output);
		return false;
	}

	$this_comment = $simpla->comments->get_comment($this_id);

	
	if($simpla->request->get('rate') == 'down'){
		$this_comment->rate_down += 1;
		$output['value'] = $this_comment->rate_down;
	}else{
		$this_comment->rate_up += 1;
		$output['value'] = $this_comment->rate_up;
	}

	$simpla->comments->update_comment($this_id, $this_comment);

	$_SESSION['comment_rate_ids'][] = $this_id;
}
$output['success'] = 1;
echo json_encode($output);
return false;
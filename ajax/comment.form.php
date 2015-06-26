<?php
header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
//header("Pragma: no-cache");
header("Expires: -1");

if(!isset($_SESSION)){session_start();}
require_once('../api/Simpla.php');
$simpla = new Simpla();

$comment = new stdClass;
$comment->parent = $simpla->request->get('parent');
$comment->type = $simpla->request->get('type');
$comment->object_id = $simpla->request->get('object_id');
$comment->ip        = $_SERVER['REMOTE_ADDR'];

$comment_id = 0;

if($_SESSION['admin'] == 'admin')
	$comment->admin = 1;

// Автозаполнение имени для формы комментария
if(!empty($simpla->user))
	$simpla->design->assign('comment_name', $simpla->user->name);


// Принимаем комментарий
if ($simpla->request->method('post') && $simpla->request->post('comment'))
{
	$comment->name = $simpla->request->post('name');
	$comment->email = $simpla->request->post('email');
	$comment->text = $simpla->request->post('text');
	$captcha_code =  $simpla->request->post('captcha_code', 'string');
	
	// Передадим комментарий обратно в шаблон - при ошибке нужно будет заполнить форму
	$simpla->design->assign('comment', $comment);
	
	// Проверяем капчу и заполнение формы
	if ($_SESSION['captcha_code'] != $captcha_code || empty($captcha_code))
	{
		$simpla->design->assign('error', 'captcha');
	}
	elseif (empty($comment->name))
	{
		$simpla->design->assign('error', 'empty_name');
	}
	elseif (empty($comment->email))
	{
		$simpla->design->assign('error', 'empty_email');
	}
	elseif (empty($comment->text))
	{
		$simpla->design->assign('error', 'empty_comment');
	}
	else
	{
		// Создаем комментарий
		// Если были одобренные комментарии от текущего ip, одобряем сразу
		$simpla->db->query("SELECT 1 FROM __comments WHERE approved=1 AND ip=? LIMIT 1", $comment->ip);
		if($simpla->db->num_rows()>0)
			$comment->approved = 1;
		
		// Добавляем комментарий в базу
		$comment_id = $simpla->comments->add_comment($comment);
		
		// Отправляем email
		$simpla->notify->email_comment_admin($comment_id);

		//возвращаем аяксом новый комментарий
		$new_comment = $simpla->comments->get_comment($comment_id);
		$simpla->design->assign('new_comment', $comment);
		$output = $simpla->design->fetch('view/ajax/comment.tpl');

		echo json_encode($output);
		return false;
		
		// Приберем сохраненную капчу, иначе можно отключить загрузку рисунков и постить старую
		unset($_SESSION['captcha_code']);			
	}

}
$output = $simpla->design->fetch('view/ajax/comment.form.tpl');
echo json_encode($output);
return false;
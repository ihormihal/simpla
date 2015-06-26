<?php
include('kcaptcha.php');
if(!isset($_SESSION)){session_start();}
$captcha = new KCAPTCHA();

if($_REQUEST[session_name()]){
	$_SESSION['captcha_code'] = $captcha->getKeyString();
}
?>
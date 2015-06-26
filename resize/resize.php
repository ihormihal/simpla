<?php

require_once('../api/Simpla.php');

$filename = $_GET['file'];
$token = $_GET['token'];
if(is_uploaded_file($_FILES["filename"]["tmp_name"])){move_uploaded_file($_FILES["filename"]["tmp_name"], "../compiled/".$_FILES["filename"]["name"]);}
$simpla = new Simpla();

if(!$simpla->config->check_token($filename, $token))
	exit('bad tokens');		

$resized_filename =  $simpla->image->resize($filename);

if(is_readable($resized_filename))
{
	header('Content-type: image');
	print file_get_contents($resized_filename);
}
<?php
error_reporting(E_ALL | E_STRICT);
ini_set('display_errors', 1);

if(!isset($_SESSION)){session_start();}
require_once('api/Simpla.php');
$simpla = new Simpla();

$query = $simpla->db->placehold("SELECT c.id, c.name, c.admin, c.text FROM __comments c WHERE name LIKE 'Александр' ");

//$query = $simpla->db->placehold("UPDATE __comments SET admin=1 WHERE name LIKE '%Админ%'");

//$query = $simpla->db->placehold("SELECT c.id, c.name, c.admin FROM __comments c");

//$query = $simpla->db->placehold("SELECT c.id, c.name, c.admin FROM __comments c WHERE admin = 1");

echo "<pre>";
if($simpla->db->query($query))
	print_r($simpla->db->results());

echo "</pre>";
<?php
require_once('View.php');

class Comments extends View
{
	function fetch()
	{
		return $this->design->fetch('comments.tpl');
	}
}
<?php

require_once('api/Simpla.php');

class BlogCategoriesAdmin extends Simpla
{
	public function fetch()
	{
		// Обработка действий
		if($this->request->method('post'))
		{
			// Действия с выбранными
			$ids = $this->request->post('check');
			if(is_array($ids))
			switch($this->request->post('action'))
			{
			    case 'delete':
			    {
				    foreach($ids as $id)
						$this->blog_categories->delete_category($id); 
						echo 'deleted'.$id;   
			        break;
			    }
			}				
		}
	
		
		$categories = $this->blog_categories->get_categories();
		
		$this->design->assign('categories', $categories);
		return $this->design->fetch('blog_categories.tpl');
	}
}

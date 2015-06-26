<?PHP

require_once('api/Simpla.php');

class BlogCategoryAdmin extends Simpla
{
	public function fetch()
	{
		$category = new stdClass;
		if($this->request->method('post'))
		{
			$category->id = $this->request->post('id', 'integer');
			$category->name = $this->request->post('name');

			$category->url = $this->request->post('url', 'string');
			$category->meta_title = $this->request->post('meta_title');
			$category->meta_keywords = $this->request->post('meta_keywords');
			$category->meta_description = $this->request->post('meta_description');
			
			$category->annotation = $this->request->post('annotation');

 			// Не допустить одинаковые URL разделов.
			if(($a = $this->blog->get_post($category->url)) && $a->id!=$category->id)
			{			
				$this->design->assign('message_error', 'url_exists');
			}
			else
			{
				if(empty($category->id))
				{
	  				$category->id = $this->blog_categories->add_category($category);
	  				$category = $this->blog_categories->get_category($category->id);
					$this->design->assign('message_success', 'added');
	  			}
  	    		else
  	    		{
  	    			$this->blog_categories->update_category($category->id, $category);
  	    			$category = $this->blog_categories->get_category($category->id);
					$this->design->assign('message_success', 'updated');
  	    		}
			}
		}
		else
		{
			$category->id = $this->request->get('id', 'integer');
			$category = $this->blog_categories->get_category(intval($category->id));
		}

		if(empty($category))
		{
			$category = new stdClass;
		}
 		
		$this->design->assign('category', $category);
		
		
 	  	return $this->design->fetch('blog_category.tpl');
	}
}
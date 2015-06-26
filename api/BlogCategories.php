<?php

require_once('Simpla.php');

class BlogCategories extends Simpla
{

	public function get_category($id)
	{
		if(is_int($id)){
			$where = $this->db->placehold(' WHERE c.id=? ', intval($id));
		}
		else{
			$where = $this->db->placehold(' WHERE c.url=? ', (string)$id);
		}
		
		$query = $this->db->placehold("SELECT c.id, c.name, c.url, c.annotation, c.meta_title,
		                               c.meta_keywords, c.meta_description
		                               FROM __blog_categories c $where LIMIT 1");
		if($this->db->query($query))
			return $this->db->result();
		else
			return false; 
	}

	public function get_categories()
	{	
		// По умолчанию
		$categorys = array();

		$query = $this->db->placehold("SELECT c.id, c.name, c.url, c.annotation, c.meta_title,
		                               c.meta_keywords, c.meta_description
		                                FROM __blog_categories c ORDER BY name DESC, id DESC");
		
		$this->db->query($query);
		return $this->db->results();
	}
	
	
	public function add_category($category)
	{	
		$query = $this->db->placehold("INSERT INTO __blog_categories SET ?%", $category);
		
		if(!$this->db->query($query))
			return false;
		else
			return $this->db->insert_id();
	}
	
	
	/*
	*
	* Обновить категорию
	* @param $category
	*
	*/	
	public function update_category($id, $category)
	{
		$query = $this->db->placehold("UPDATE __blog_categories SET ?% WHERE id in(?@) LIMIT ?", $category, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}


	/*
	*
	* Удалить категорию
	* @param $id
	*
	*/	
	public function delete_category($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __blog_categories WHERE id=? LIMIT 1", intval($id));		
			if($this->db->query($query))
				return true;					
		}
		return false;
	}
	
}

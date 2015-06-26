<?php

/**
 * Simpla CMS
 *
 * @copyright	2011 Denis Pikusov
 * @link		http://simplacms.ru
 * @author		Denis Pikusov
 *
 */

require_once('Simpla.php');

class Comments extends Simpla
{

	// Возвращает комментарий по id
	public function get_comment($id)
	{
		$query = $this->db->placehold("SELECT c.id, c.parent, c.object_id, c.name, c.email, c.ip, c.type, c.text, c.date, c.approved, c.admin, c.rate_up, c.rate_down FROM __comments c WHERE id=? LIMIT 1", intval($id));

		if($this->db->query($query))
			return $this->db->result();
		else
			return false; 
	}
	
	// Возвращает комментарии, удовлетворяющие фильтру
	public function get_comments($filter = array())
	{	
		// По умолчанию
		$limit = 0;
		$page = 1;
		$object_id_filter = '';
		$type_filter = '';
		$keyword_filter = '';
		$approved_filter = '';
		$parent_filter = '';

		if(isset($filter['parent']))
			$parent_filter = $this->db->placehold("AND c.parent=?", intval($filter['parent']));

		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));

		if(isset($filter['ip']))
			$ip = $this->db->placehold("OR c.ip=?", $filter['ip']);
		if(isset($filter['approved']))
			$approved_filter = $this->db->placehold("AND (c.approved=? $ip)", intval($filter['approved']));
			
		if($limit)
			$sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);
		else
			$sql_limit = '';

		if(!empty($filter['object_id']))
			$object_id_filter = $this->db->placehold('AND c.object_id in(?@)', (array)$filter['object_id']);

		if(!empty($filter['type']))
			$type_filter = $this->db->placehold('AND c.type=?', $filter['type']);

		if(!empty($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND c.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR c.text LIKE "%'.$this->db->escape(trim($keyword)).'%" ');
		}

			
		$sort='DESC'; 
		
		$query = $this->db->placehold("SELECT c.id, c.parent, c.object_id, c.ip, c.name, c.email, c.text, c.type, c.date, c.approved, c.admin, c.rate_up, c.rate_down
										FROM __comments c WHERE 1 $object_id_filter $type_filter $keyword_filter $approved_filter $parent_filter ORDER BY id $sort $sql_limit");
	
		$this->db->query($query);
		$comments = $this->db->results();

		return $this->buildTree($comments);
	}

	private function buildTree(array &$elements, $parentId = 0) {
		$comments_tree = array();

	    foreach ($elements as $element) {
	        if ($element->parent == $parentId) {
	            $children = $this->buildTree($elements, $element->id);
	            if ($children) {
	                $element->children = $children;
	            }
	            $comments_tree[$element->id] = $element;
	           unset($elements[$element->id]);
	        }
	    }
	    return $comments_tree;
	}
	
	// Количество комментариев, удовлетворяющих фильтру
	public function count_comments($filter = array())
	{	
		$object_id_filter = '';
		$type_filter = '';
		$approved_filter = '';
		$keyword_filter = '';
		$parent_filter = '';

		if(isset($filter['parent']))
			$parent_filter = $this->db->placehold('AND c.parent=?', intval($filter['parent']));

		if(!empty($filter['object_id']))
			$object_id_filter = $this->db->placehold('AND c.object_id in(?@)', (array)$filter['object_id']);

		if(!empty($filter['type']))
			$type_filter = $this->db->placehold('AND c.type=?', $filter['type']);

		if(isset($filter['approved']))
			$approved_filter = $this->db->placehold('AND c.approved=?', intval($filter['approved']));

		if(!empty($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND c.name LIKE "%'.$this->db->escape(trim($keyword)).'%" OR c.text LIKE "%'.$this->db->escape(trim($keyword)).'%" ');
		}

		$query = $this->db->placehold("SELECT count(distinct c.id) as count
										FROM __comments c WHERE 1 $object_id_filter $type_filter $keyword_filter $approved_filter $parent_filter", $this->settings->date_format);
	
		$this->db->query($query);	
		return $this->db->result('count');

	}
	
	// Добавление комментария
	public function add_comment($comment)
	{	
		$query = $this->db->placehold('INSERT INTO __comments
		SET ?%,
		date = NOW()',
		$comment);

		if(!$this->db->query($query))
			return false;

		$id = $this->db->insert_id();
		return $id;
	}
	
	// Изменение комментария
	public function update_comment($id, $comment)
	{
		$date_query = '';
		if(isset($comment->date))
		{
			$date = $comment->date;
			unset($comment->date);
			$date_query = $this->db->placehold(', date=STR_TO_DATE(?, ?)', $date, $this->settings->date_format);
		}
		$query = $this->db->placehold("UPDATE __comments SET ?% $date_query WHERE id in(?@) LIMIT 1", $comment, (array)$id);
		$this->db->query($query);
		return $id;
	}

	// Удаление комментария
	public function delete_comment($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __comments WHERE id=? LIMIT 1", intval($id));
			$this->db->query($query);
		}
	}	
}

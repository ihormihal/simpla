<?php

require_once('Simpla.php');


class Contacts extends Simpla
{

	public function get_place($id)
	{
		if(is_int($id)){
			$where = $this->db->placehold(' WHERE c.id=? ', intval($id));
		}
		
		$query = $this->db->placehold("SELECT c.id, c.title, c.city, c.latlng, c.address, c.phone, c.email, c.skype, c.schedule, c.description, c.position, c.enabled
		                               FROM __contacts c $where LIMIT 1");
		if($this->db->query($query))
			return $this->db->result();
		else
			return false; 
	}

	public function get_places()
	{	
		// По умолчанию
		$places = array();

		$query = $this->db->placehold("SELECT c.id, c.title, c.city, c.latlng, c.address, c.phone, c.email, c.skype, c.schedule, c.description, c.position, c.enabled
		                                FROM __contacts c ORDER BY position"); 
		
		$this->db->query($query);
		return $this->db->results();
	}
	
	
	public function add_place($place)
	{	
		$query = $this->db->placehold("INSERT INTO __contacts SET ?%", $place);
		
		if(!$this->db->query($query))
			return false;
		else
			return $this->db->insert_id();
	}
	
	
	/*
	*
	* Обновить место
	* @param $place
	*
	*/	
	public function update_place($id, $place)
	{
		$query = $this->db->placehold("UPDATE __contacts SET ?% WHERE id in(?@) LIMIT ?", $place, (array)$id, count((array)$id));
		$this->db->query($query);
		return $id;
	}


	/*
	*
	* Удалить место
	* @param $id
	*
	*/	
	public function delete_place($id)
	{
		if(!empty($id))
		{
			$query = $this->db->placehold("DELETE FROM __contacts WHERE id=? LIMIT 1", intval($id));		
			if($this->db->query($query))
				return true;					
		}
		return false;
	}
	
}

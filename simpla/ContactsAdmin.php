<?PHP 

require_once('api/Simpla.php');

########################################
class ContactsAdmin extends Simpla
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
			    case 'disable':
			    {
					$this->contacts->update_place($ids, array('enabled'=>0));	      
					break;
			    }
			    case 'enable':
			    {
					$this->contacts->update_place($ids, array('enabled'=>1));	      
			        break;
			    }
			    case 'delete':
			    {
				    foreach($ids as $id)
						$this->contacts->delete_place($id);    
			        break;
			    }
			}
			// Сортировка
			$positions = $this->request->post('positions'); 		
	 		$ids = array_keys($positions);
			sort($positions);
			foreach($positions as $i=>$position)
				$this->contacts->update_place($ids[$i], array('position'=>$position)); 
			
	 	}


		// Отображение
	  	$places = $this->contacts->get_places();
	 	$this->design->assign('places', $places);
		return $this->design->fetch('contacts.tpl');
	}
}
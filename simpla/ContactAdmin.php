<?PHP

require_once('api/Simpla.php');

class ContactAdmin extends Simpla
{
	public function fetch()
	{
		$place = new stdClass;
		if($this->request->method('post'))
		{
			$place->id = $this->request->post('id', 'integer');
			$place->title = $this->request->post('title');
			$place->city = $this->request->post('city','string');

			$place->address = $this->request->post('address');
			$place->latlng = $this->request->post('latlng');

			$place->enabled = $this->request->post('enabled', 'boolean');
			
			$place->description = $this->request->post('description');

			$place->email = $this->request->post('email');
			$place->skype = $this->request->post('skype');

			$phones = $this->request->post('phone','array');
			$place->phone = json_encode($phones);

			$schedule = $this->request->post('schedule','array');
			$place->schedule = json_encode($schedule);

 			if(empty($place->id))
			{
  				$place->id = $this->contacts->add_place($place);
  				$place = $this->contacts->get_place($place->id);
				$this->design->assign('message_success', 'added');
  			}
    		else
    		{
    			$this->contacts->update_place($place->id, $place);
    			$place = $this->contacts->get_place($place->id);
			$this->design->assign('message_success', 'updated');
    		}
		}
		else
		{
			$place->id = $this->request->get('id', 'integer');
			$place = $this->contacts->get_place(intval($place->id));

			$phones = json_decode($place->phone,true);
			$schedule = json_decode($place->schedule,true);
		}

		if(empty($place))
		{
			$place = new stdClass;
		}


 		
		$this->design->assign('place', $place);
		$this->design->assign('phones', $phones);
		$this->design->assign('schedule', $schedule);
		
		
 	  	return $this->design->fetch('contact.tpl');
	}
}
<?PHP
require_once('api/Simpla.php');

class CommentAdmin extends Simpla
{	

	public function fetch()
	{	
		if($this->request->method('post'))
		{

			$parent_id = $this->request->get('id', 'integer');
			$parent_comment = $this->comments->get_comment($parent_id);
			// Создаем комментарий
			$comment = new stdClass();
			$comment->object_id = $parent_comment->object_id;
			$comment->parent 	= $parent_id;
			$comment->type      = $parent_comment->type;
			$comment->name 		= 'Администратор';
			$comment->text   	= $this->request->post('text');
			$comment->approved  = 1;
			$comment->admin     = 1;

			// Добавляем комментарий в базу
			$comment_id = $this->comments->add_comment($comment);

			//отправляем ответ письмом автору комментария
			if($parent_comment->email){
				$this->notify->email_comment_user($comment_id);
			}
			
			if($comment_id)
			{
				$this->design->assign('message_success', 'success');
			}

		}
		else
		{
			$comment_id = $this->request->get('id', 'integer');
			if(!empty($comment_id))
			{
				$comment = $this->comments->get_comment($comment_id);
			}

		}	
		
		$this->design->assign('comment', $comment);

		
  	  	return $this->design->fetch('comments/comment_admin.tpl');
	}
	
}			




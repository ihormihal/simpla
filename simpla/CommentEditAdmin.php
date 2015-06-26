<?PHP
require_once('api/Simpla.php');

class CommentEditAdmin extends Simpla
{	

	public function fetch()
	{	
		if($this->request->method('post'))
		{
			$comment->id 			= $this->request->post('id', 'integer');
			$comment->approved      = $this->request->post('approved', 'boolean');
			$comment->text   		= $this->request->post('text');
			$get_comment 			= $this->comments->get_comment($comment->id);
			
			if($comment->id)
			{
				$this->comments->update_comment($comment->id, $comment);
				$this->design->assign('message_success', 'added');
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

		
  	  	return $this->design->fetch('comments/comment_edit.tpl');
	}
	
}
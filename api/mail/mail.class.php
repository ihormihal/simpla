<?php
class SMTPMailer {
	function smtpmail($to, $subject, $body, $from = '', $reply_to = '', $from_text = '') {
		require_once 'class.phpmailer.php';

		$subject = "=?utf-8?B?".base64_encode($subject)."?=";
		//$from_text = "=?utf-8?B?".base64_encode($from_text)."?=";

		global $error;
		$mail = new PHPMailer();  // create a new object
		$mail->IsSMTP(); // enable SMTP
		$mail->SMTPDebug = 0;  // debugging: 1 = errors and messages, 2 = messages only
		$mail->SMTPAuth = true;  // authentication enabled
		$mail->SMTPSecure = 'tls'; // secure transfer enabled REQUIRED for GMail
		$mail->Host = 'smtp.gmail.com';
		$mail->Port = 587; 
		$mail->Username = 'ihor.mihal@gmail.com';  
		$mail->Password = 'leantt38'; 
		if($from_text != '') {
			$from_text = "=?utf-8?B?".base64_encode($from_text)."?=";
			$mail->SetFrom($from, $from_text);
		}elseif($from_text == ''){
			$mail->SetFrom($from, 'SHOP-GSM.NET');
		}     
		$mail->Subject = $subject;
		$mail->MsgHTML($body);
		$mail->AddAddress($to);
		if(!$mail->Send()) {
			//echo $mail->ErrorInfo;
			$error = 'Mail error: '.$mail->ErrorInfo;
			//echo '<pre>'.$error.'<pre>';
			return false;
		} else {
			$error = 'Message sent!';
			return true;
		}
	}
}
?>

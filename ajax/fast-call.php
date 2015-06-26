<?php 
require_once $_SERVER['DOCUMENT_ROOT'].'/api/mail/mail.class.php';
$output = array();

$mailer = new SMTPMailer();

  $name = $_POST['name'];
  $phone = $_POST['phone'];
  $url = $_POST['url'];

  $replace = array('(',')','-',' ');
  $phone_temp = str_replace($replace,'',$phone);


  $title = "Заказ звонка от $name на номер $phone";


  $message = " 
  <html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <style>BODY {FONT-FAMILY: arial,verdana,helvetica;}</style></head>
  <body>
    Страница отправки: <b><a href='".$url."'>$url</a></b>; <br>
    Имя отправителя: <b>".$name."</b>; <br>
    Контактный телефон: <b>".$phone."</b>; <br>
  <BR><BR><BR>* Это сообщение сгенерировано и отправлено роботом с формы заказа обратного звонка.</body></html>";

  $to = 'info@shop-gsm.net';

  $status == false;

  if($_SERVER['REQUEST_METHOD'] == 'POST') {
    if(strlen($phone) == 15 && strlen($phone_temp) == 10){
      $status = $mailer->smtpmail($to, $title, $message, $from = 'order@shop-gsm.net', '', $name);
    }else{
      $status == false;
    }
    if($status == true){
      $output['title'] = "Спасибо, $name!";
      $output['message'] = "Ми перезвоним Вам как можно скорее!";
    }else{
      $output['title'] = "Ошибка!";
      $output['message'] = "Что-то пошло не так. Мы не получили Вашу заявку.";
    }
  }else{
    header("Location:".$_SERVER['HTTP_REFERER']);
  }

  header("Content-type: application/json; charset=UTF-8");
  header("Cache-Control: must-revalidate");
  header("Pragma: no-cache");
  header("Expires: -1");    
  echo json_encode($output);

?>
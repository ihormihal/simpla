<?php 
require_once $_SERVER['DOCUMENT_ROOT'].'/api/mail/mail.class.php';
$output = array();

$mailer = new SMTPMailer();

  $name = $_POST['name'];
  $phone = $_POST['phone'];
  $url = $_POST['url'];
  $price = $_POST['price'];
  $product = $_POST['product'];
  $show_discount = $_POST['show_discount'];
  $discount = $_POST['discount'].'%';

  if($show_discount !== 'on'){
    $discount = "не указано";
  }

  $replace = array('(',')','-',' ');
  $phone_temp = str_replace($replace,'',$phone);


  $title = "Запрос на снижение цены от $name";


  $message = " 
  <html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <style>BODY {FONT-FAMILY: arial,verdana,helvetica;}</style></head>
  <body>
    Страница отправки: <b><a href='".$product."'>$url</a></b>; <br>
    Цена товара на момент запроса: <b>$price</b>; <br>
    Ожидаемая скидка: <b>$discount</b>; <br>
    Имя отправителя: <b>$name</b>; <br>
    Контактный телефон: <b>$phone</b>; <br>
  <BR><BR><BR>* Это сообщение сгенерировано и отправлено роботом с формы уведомления на снижение стоимости товара.</body></html>";

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
      $output['message'] = "Мы сообщим Вам, как только снизится цена на этот товар!";
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
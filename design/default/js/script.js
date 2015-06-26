$(function(){
	

	//асинхронная загрузка контента
	$('.ajax-content').each(function(){
		var container = $(this);
		$.ajax({
			url: $(this).attr('data-url')
		}).done(function(response){
			container.html(response);
		});
	});


	$(document).on('click', '.comment-answer', function(e){
		e.preventDefault();
		var formConteiner = $(this).attr('data-form');
		$.ajax({
			url: $(this).attr('href')
		}).done(function(response){
			$('.comment-form').html('');
			$(formConteiner).html(response);
		});
	});

	//голосование за коммент
	$(document).on('click', '.rate-comment', function(e){
		e.preventDefault();
		var counter = $(this).find('span');
		$.ajax({
			url: $(this).attr('href')
		}).done(function(response){
			if(response.success){
				counter.html(response.value);
			}else{
				alert(response.message);
			}
		});
	});

	//обработка формы добавления комментария
	$(document).on('submit', '#ajax-comment-form', function(e){
		e.preventDefault();
		var form = $(this);
		var container = form.parent();

		var isAnswer = true;
		if(container.attr('class') == 'ajax-content'){
			isAnswer = false;
		}

		$.ajax({
			url: form.attr('action'),
			data: form.serialize(),
			type: 'post'
		}).done(function(response){
			if(isAnswer){
				container.html(response);
			}else{
				//если это не форма ответа, проверяем, что пришло, если ок -> оставляем форму, ресетим, добавляем коммент
				if(response.indexOf('ajax-comment-form') == -1){
					form.find('.message_error').remove();
					form.find('input[type=text], input[type=email], textarea').val('');
					$('#comments > ul').prepend(response);
				}else{
					container.html(response);
				}
			}
		});
	});

});
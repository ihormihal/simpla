$(function() {

fixHeights();

$('.fancy').fancybox({
  maxWidth    : 480,
  maxHeight   : 640,
  padding     : 30,
  fitToView : false,
  autoSize  : true,
  closeClick  : false,
  openEffect  : 'fade',
  closeEffect : 'fade',
  wrapCSS: 'dark',
  helpers : {
    overlay : {
      opacity: 0.4,
      locked: true
    }
  }
});

$('.fancybox').fancybox({
  maxWidth    : 800,
  maxHeight   : 600,
  padding     : 0,
  fitToView   : false,
  width       : '70%',
  height      : '70%',
  autoSize    : false,
  closeClick  : false,
  openEffect  : 'fade',
  closeEffect : 'fade',
  wrapCSS: 'document',
  helpers : {
    overlay : {
      opacity: 0.4,
      locked: false
    }
  }
});

//AJAX-поиск
$('#search-form .input').on('keyup', function(){
  if($(this).val().length < 2){
    $('#search-form .search-results').hide();
    return false;
  }
  $.ajax({
    url: 'ajax/search_products.php',
    data: {'query':$(this).val()}
  }).done(function(data){
    var results = '';
    $.each(data.suggestions, function(index, value){
      results+= '<li><a href="products/'+value.data.url+'"><div class="image"><img src="'+value.data.image+'"></div><div class="title">'+value.data.name+'</div></a></li>';
    });
    if(results){
      $('#search-form .search-results').show();
      $('#search-form .results').html(results);
    }else{
      $('#search-form .search-results').hide();
    }
  });
});

$('form#filter').on('change','input:not([name=cost])',function(e){
  e.preventDefault();
  $('form#filter input[name=page]').val(1);
  ajaxFilter();
});

//пагинация в товарах
$('#products').on('click','.pagination li a',function(e){
  e.preventDefault();
  var page = $(this).attr('href');
  $('form#filter input[name=page]').val(page);
  ajaxFilter();
});

//price slider
$('#range').ionRangeSlider({
  grid: true,
  onFinish: function (data) {
    $('form#filter input[name=page]').val(1);
    ajaxFilter();
  }
});

//асинхронная загрузка контента
$('.ajax-content').each(function(){
  var container = $(this);
  $.ajax({
    url: $(this).attr('data-url')
  }).done(function(response){
    container.html(response);
  });
});

//подгружаем форму ответа на комментарий
$(document).on('click', '.comment-answer', function(e){
  e.preventDefault();
  var formConteiner = $(this).data('form');
  $.ajax({
    url: $(this).attr('href')
  }).done(function(response){
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
        form.find('label span').remove();
        form.find('input[type=text], input[type=email], textarea').val('');
        $('#comments > ul').prepend(response);
      }else{
        container.html(response);
      }
    }
  });
});

//Голосование за продукт
$('.rating .live span').on('click',function(){
  var id = $(this).closest('.rating').find('.live').data('id');
  var on = $(this).closest('.rating').find('.on');
  var rate = $(this).closest('.rating').find('.rate');
  var votes = $(this).closest('.rating').find('.votes span');
  var rate_val = $(this).data('rate');
  $.ajax({
    url: '/ajax/product.rate.php',
    data: {rate: rate_val, id: id}
  }).done(function(response){
    if(response.success){
      on.width(response.rate_width);
      rate.html(response.rate);
      votes.html(response.votes);
      alert('success!');
    }else{
      alert(response.message);
    }
  });
})

//connected select <-> ul.hlist
$(document).on('change','.select-source',function(){
  var target = $(this).data('target');
  var item = $(this).find('option:selected').data('item');
  $(target).find('li').removeClass('active');
  $(target).find('li[data-item="'+item+'"]').addClass('active');
});

$('form#cart-form').on('change','input.amounts',function(){
  $('form#cart-form').submit();
});


//AJAX-CART
$(document).on('submit','.product form, .header-fixed form', function(e){
  e.preventDefault();
  $.ajax({
    url: $(this).attr('action'),
    method: $(this).attr('method'),
    data: $(this).serialize()
  }).done(function(response){
    $('.ajax-cart').html(response);
    $('input.phone').mask("(999) 999-99-99");
    $('.ajax-cart-text').html('<a class="btn btn-blue" href="./cart/"><i class="fa fa-check"></i> Оформить заказ</a>');
    $.fancybox.open({href : '#in-cart'},{
      padding     : 30,
      fitToView : false,
      autoSize  : true,
      closeClick  : false,
      openEffect  : 'fade',
      closeEffect : 'fade',
      wrapCSS: 'dark',
      helpers : {
        overlay : {
          opacity: 0.4,
          locked: true
        }
      }  
    });
  });
});

//ajax-callback form
$(document).on('submit','#callback form, #check-price-cut form', function(e){
  e.preventDefault();
  var form = $(this);
  $.ajax({
    url: form.attr('action'),
    method: form.attr('method'),
    data: form.serialize()
  }).done(function(response){
    $.fancybox.close();
    $.toast({
      text : response.message,
      heading: response.title
    });
  });
});

//set active menu items
$('#main-nav > li').each(function(){
  var state = $(this).find('.item-state').text();
  if(state == 'active'){
    $(this).addClass('active');
  }
});

//mobile menu accordeon
$(document).on('click touchstart','.nav-main-mobile li.parent',function(e){
  e.stopPropagation();
  if(e.target.nodeName === 'LI'){
    var ul = $(e.target).find('> ul');
    if(ul.is(':visible')){
      ul.slideUp(250,function(){
        $(e.target).removeClass('active');
      });
    }else{
      ul.slideDown(250,function(){
        $(e.target).addClass('active');
      });
    }
  } 
});

//replace to bottom seo-text
$('#seo-wrapper').html($('#seo-text'));

//tabs
$('.tabs-menu a').click(function(e) {
  e.preventDefault();
  $(this).parent().addClass('current');
  $(this).parent().siblings().removeClass('current');
  var tab = $(this).attr('href');
  $('.tab-content').not(tab).hide();
  $(tab).fadeIn();
});
$('.tabs-menu .current a').click();

//***** COMMENT PAGINATION END *****/

$('input.phone').mask("(999) 999-99-99");
$('.phone-list .phone-xx').each(function(){
  var phone = $(this).text().slice(0,7) + '-xx';
  $(this).text(phone);
});

$('.header-fixed a').click(function(e){
  e.preventDefault();
  $('html, body').animate({ scrollTop: $('.horizontal-tabs').offset().top-60 }, 250);
  $($(this).attr('href')).click();  
});

//apply AJAX-filter on load
if($('#filter').length > 0){
  var priceSlider = $("#range").data("ionRangeSlider");
  var hash = window.location.hash;
  if(hash){
    var params = hash.substr(1).split(',');

    for(var i = 0; i < params.length; i++){
      var param = params[i].split('=');
      switch(param[0]){
        case 'features':
          var values = param[1].split(';');
          for(var j = 0; j < values.length; j++){
            $('#f'+values[j]).prop('checked', true);
          }
          break;
        case 'price':
          var values = param[1].split(';');
          priceSlider.update({from: values[0], to: values[1]});
          break;
        case 'sort':
          $('.filter input[name=sort]').filter('[value='+param[1]+']').prop('checked', true);
          break;
        default:
          break;
      }
    }
    ajaxFilter();
  }
}


}); //jQuery end

window.resize = function(){
  //console.log('resize');
  fixHeights();
};

window.onscroll = function(){
  if(window.innerWidth > 768){
    fixHeader();
  }
};

var fixHeights = function(){
  var height = 0;
  $('.fixh').each(function(){
    if($(this).height() > height){
      height = $(this).height();
    }
  });
  $('.fixh').css('height',height);
};


/**************************************/
/******* SHOW-HIDE BUTTON CLICK *******/
/**************************************/
$(document).on('click','.btn-show-click', function(e){
  var button = $(this);
  var target = $(this).data('target');
  if(button.hasClass('hover')){
    button.removeClass('hover');
    if(target){
      $(target).slideUp();
    }
  }else{
    button.addClass('hover');
    if(target){
      $(target).slideDown();
    }
  }
});

var ajaxFilter = function(){
  var hash = [];
  var features = [];
  $('.feature-filter input[type=checkbox]:checked').each(function(){
    features.push($(this).attr('id').substr(1));
  });
  if(features.length > 0){
    hash.push('features='+features.join(';'));
  }
  hash.push('price='+$('#range').val());
  hash.push('sort='+$('.filter input[name=sort]').val());

  window.location.hash = hash.join(',');

  $.ajax({
    url: $('form#filter').attr('action'),
    data: $('form#filter').serialize()
  }).done(function(response){
    $('#products').html(response);
    fixHeights();
    $('html, body').animate({
      scrollTop: $("#products").offset().top-30
    }, 500);
  });
};

/**** FIXED HEADER ****/
var header_fixed = 0;
var header_fixed_pre = 0;
var fixHeader = function(){
  header_fixed = window.pageYOffset > 400 ? 1 : 0;
  if(header_fixed_pre !== header_fixed){
    //параметр изменился
    if(header_fixed){
      $('.header-fixed').fadeIn(250);
    }else{
      $('.header-fixed').hide();
    }
  }
  header_fixed_pre = header_fixed;
};

/********** copy protection ******/
function addLink() {
  var body_element = document.getElementsByTagName('body')[0];
  var selection = window.getSelection();

  var pagelink = "<p>Читайте подробнее: <a href='"+document.location.href+"'>"+document.location.href+"</a> - SHOP-GSM.NET</p>";
  var copytext = selection + pagelink;
  var newdiv = document.createElement('div');
  newdiv.style.position = 'absolute';
  newdiv.style.left = '-99999px';
  body_element.appendChild(newdiv);
  newdiv.innerHTML = copytext;
  selection.selectAllChildren(newdiv);
  window.setTimeout( function() {
  body_element.removeChild(newdiv);
  }, 0);
}
document.oncopy = addLink;


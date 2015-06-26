jQuery(document).ready(function($) {

$('.recently-viewed').owlCarousel({
  navigation : false,
  slideSpeed : 300,
  paginationSpeed : 400,
  singleItem:true
});


/************ OWL SYNTH CAROUSEL **********/
var owlSlider = $("#owl-slider");
var owlCarousel = $("#owl-carousel");

owlSlider.owlCarousel({
  singleItem : true,
  slideSpeed : 750,
  navigation: false,
  pagination: true,
  afterAction : syncPosition,
  responsiveRefreshRate : 200,
  navigationText: ['<i class="fa fa-angle-left"></i>','<i class="fa fa-angle-right"></i>']
});

owlCarousel.owlCarousel({
  items : 4,
  itemsDesktop      : [1199,3],
  itemsDesktopSmall : [979,3],
  itemsTablet       : [768,3],
  itemsMobile       : [479,2],
  pagination:false,
  responsiveRefreshRate : 100,
  afterInit : function(el){
    el.find(".owl-item").eq(0).addClass("active");
  }
});

function syncPosition(el){
  var current = this.currentItem;
  owlCarousel
    .find(".owl-item")
    .removeClass("active")
    .eq(current)
    .addClass("active")
  if(owlCarousel.data("owl-carousel") !== undefined){
    center(current)
  }
}

owlCarousel.on("click", ".owl-item", function(e){
  e.preventDefault();
  var number = $(this).data("owl-item");
  owlSlider.trigger("owl.goTo",number);
});

function center(number){
  var owlCarouselvisible = owlCarousel.data("owl-carousel").owl.visibleItems;
  var num = number;
  var found = false;
  for(var i in owlCarouselvisible){
    if(num === owlCarouselvisible[i]){
      var found = true;
    }
  }

  if(found===false){
    if(num>owlCarouselvisible[owlCarouselvisible.length-1]){
      owlCarousel.trigger("owl.goTo", num - owlCarouselvisible.length+2)
    }else{
      if(num - 1 === -1){
        num = 0;
      }
      owlCarousel.trigger("owl.goTo", num);
    }
  } else if(num === owlCarouselvisible[owlCarouselvisible.length-1]){
    owlCarousel.trigger("owl.goTo", owlCarouselvisible[1])
  } else if(num === owlCarouselvisible[0]){
    owlCarousel.trigger("owl.goTo", num-1)
  } 
}

});

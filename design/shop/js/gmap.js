jQuery(document).ready(function($) {

    var map;
    var companyPos = new google.maps.LatLng($('.contact-tabs ul li.current').data('lat'), $('.contact-tabs ul li.current').data('lng'));
    var mapZoom = $('.contact-tabs ul li.current').data('zoom');
    var directionsDisplay = new google.maps.DirectionsRenderer();
    var directionsService = new google.maps.DirectionsService();

    var mapOptions = {
        zoom: mapZoom,
        center: companyPos,
        panControl: true,
        zoomControl: true,
        mapTypeControl: true,
        scaleControl: true,
        draggable: true,
        scrollwheel: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        styles: [{
            stylers: [{
                hue: "#00aeef"
            }, {
                saturation: 1
            }, {
                lightness: 1
            }, {
                gamma: 1
            }, {
                featureType: "landscape.man_made",
                stylers: [{
                    visibility: "on"
                }]
            }]
        }]
    };

    

    var companyImage = new google.maps.MarkerImage($('#shop-map').data('pin'),
        new google.maps.Size(154, 133),
        new google.maps.Point(0, 0),
        new google.maps.Point(60, 120)
    );

    map = new google.maps.Map(document.getElementById('shop-map'), mapOptions);

    //var locations = array();

    //var bounds = new google.maps.LatLngBounds();
    var markers = [];
    $('.contact-tabs ul li').each(function(){
        marker = new google.maps.Marker({
            position: new google.maps.LatLng($(this).data('lat'), $(this).data('lng')),
            map: map,
            icon: companyImage
        });
        markers.push(marker);
        //bounds.extend(marker.position);
    });
    //map.fitBounds(bounds);

    $('.contact-tabs ul li').click(function(){
        var marker = markers[$('.contact-tabs ul li').index(this)];
        jump_to_marker(marker, marker.position, $(this).data('zoom'));
    });

    function jump_to_marker (marker, position, zoom) {
        map.panTo(position);
        map.setZoom(zoom);
        marker.setAnimation(google.maps.Animation.DROP);
    }

});

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery.min.js
//= require angular/angular.min.js
//= require angular-resource/angular-resource.min.js
//= require angular-ui-router/release/angular-ui-router.min.js
//= require angular-bootstrap-colorpicker/js/bootstrap-colorpicker-module.min.js
//= require angular-wysiwyg/dist/angular-wysiwyg.min.js
//= require app/app.js
//= require app/app.services.js
//= require app/app.routes.js
//= require app/controllers/customersController.js
//= require app/controllers/providersController.js
//= require app/controllers/providerSearchController.js
//= require app/controllers/estimatesController.js
//= require app/controllers/recommendationsController.js
//= require app/controllers/tagCloudController.js
//= require app/controllers/featureImageController.js
//= require ng-rails-csrf
//= require providers.js
//= require jquery_ujs
//= require jquery.stellar/jquery.stellar.min.js
//= require bootstrap/dist/js/bootstrap.min.js
//= require wow/dist/wow.min.js
//= require raty/lib/jquery.raty
//= require bootstrap-notify/js/bootstrap-notify.js
//= require fancybox/source/jquery.fancybox.js
//= require jquery.lazyload/jquery.lazyload.js
//= require jquery-migrate.min.js
//= require jquery.easing.1.3.min.js
//= require jquery.sticky.js
//= require jquery.flexslider-min.js
//= require jquery.counterup.min.js
//= require jquery.isotope.min.js
//= require jquery.imagesloaded.min.js
//= require jquery.modal.js
//= require owl.carousel.min.js
//= require jquery.magnific-popup.min.js
//= require jquery.mb.YTPlayer.min.js
//= require custom.js
//= require jquery.themepunch.tools.min.js
//= require jquery.themepunch.revolution.min.js
//= require revolution-custom.js
//= require isotope-custom.js
//= require bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js
//= stub active_admin

function showFlashMessage(msg, type, seconds){

   $('.top-right').notify({
        message: { text: msg},
        fadeOut: {
            delay: seconds
        },
        type: type
      }).show();
}


   //  var myLatlng;
   //  var map;
   //  var marker;

   // function initialize(latitude, longitude, elemID, providerName) {
   //    myLatlng = new google.maps.LatLng(latitude, longitude);

   //    var mapOptions = {
   //        zoom: 13,
   //        center: myLatlng,
   //        mapTypeId: google.maps.MapTypeId.ROADMAP,
   //        scrollwheel: false,
   //        draggable: false
   //    };
   //    map = new google.maps.Map(document.getElementById('maps'), mapOptions);

   //    var contentString = '<p style="line-height: 20px;"><strong>'+providerName+'</strong></p><p></p>';

   //    var infowindow = new google.maps.InfoWindow({
   //        content: contentString
   //    });

   //    marker = new google.maps.Marker({
   //        position: myLatlng,
   //        map: map,
   //        title: 'Marker'
   //    });
   //     $("#maps").remove();

   //    google.maps.event.addListener(marker, 'click', function() {
   //        infowindow.open(map, marker);
   //    });
   // }


$(document).ready(function(){
  'use strict';

  // new WOW().init();
  $('[data-toggle="tooltip"]').tooltip();
  $( "#estimate" ).click(function() {
    $('#estimatesModal').modal('toggle');
  });
  $( "#resposta" ).click(function() {
    $('#responseModal').modal('toggle');
  });


  $.ajaxSetup({
    dataType: 'json'
  });

  $("input[name=type]:radio").change(function(){
    $('.magic').hide();
    var form = $( this ).val();
    $("#"+form).show();
  });
  $("#customer_wedding_date").datepicker({
      format: 'dd/mm/yyyy'
    });


  $('#estimatesShowModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var recipient = button.data('param');
    var modal = $(this);
    modal.data( "param", recipient );
    console.log(modal.data( "param"));
  });


  // google.maps.event.addDomListener(window, 'load', initialize);


	// $('form').bind('ajax:beforeSend', function(event, xhr, status) {

	// 	$(this).before('<img alt="Loading" id="load" class="img-responsive" src="/assets/loading.gif">');

	// });

	// $('form').bind('ajax:complete', function(event, xhr, status) {
	// 	$("#load").remove();
	// });

  // $(function () {
  //   $('[data-toggle="popover"]').popover();
  //   $('.carousel').carousel();
  // });

  // $(window).scroll(function(){
  //   var b = $(window).scrollTop();
  //   if( b > 60 ){
  //       $(".navbar").addClass("is-scrolling");
  //   } else {
  //       $(".navbar").removeClass("is-scrolling");
  //   }
  // });
  // $.stellar({
  //   horizontalScrolling: false,
  //   verticalOffset: 50
  // });
  $("img.lazy").show().lazyload({
    effect : "fadeIn"
  });

 var config = {
      ui: {
          flyout: 'top center',
          button_text: '',
          button_font: true,
          icon_font: true
        }
  };
  if($('#socialMedia').length){
     new Share("#socialMedia", config);
  }

  $( "#contact" ).click(function() {
    $('#contactModal').modal('toggle');
  });


});




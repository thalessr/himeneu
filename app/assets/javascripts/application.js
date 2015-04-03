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
//= require angular/angular.min.js
//= require angular-resource
//= require ng-rails-csrf
//= require jquery.min.js
//= require jquery_ujs
//= require jquery.autosize
//= require jquery.stellar/jquery.stellar.min.js
//= require moment
//= require bootstrap/dist/js/bootstrap.min.js
//= require wow/dist/wow.min.js
//= require bootstrap-datetimepicker
//= require raty/lib/jquery.raty
//= require bootstrap-notify/js/bootstrap-notify.js
//= require flat-ui/dist/js/flat-ui.min.js
//= require jquery-file-upload/js/jquery.fileupload.js
//= require fancybox/source/jquery.fancybox.js
//= require jquery.lazyload/jquery.lazyload.js
//= require_tree .
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

// function loadImage(){
//   var elem = $();
//   $(elem).load(function() {
//       $(elem).attr('src', $(elem).attr('data-src'));
//   });
//   $(elem).attr('src', $(elem).attr('data-src'));
// }

// loadImage();

$(document).ready(function(){
  'use strict';

	$.ajaxSetup({
	  dataType: 'json'
	})



  new WOW().init();
  $('[data-toggle="tooltip"]').tooltip();

	$('form').bind('ajax:beforeSend', function(event, xhr, status) {

		$(this).before('<img alt="Loading" id="load" class="img-responsive" src="/assets/loading.gif">');

	});

	$('form').bind('ajax:complete', function(event, xhr, status) {
		$("#load").remove();
	});

  $(function () {
    $('[data-toggle="popover"]').popover();
    $('.carousel').carousel();
  });

  $(window).scroll(function(){
    "use strict";
    var b = $(window).scrollTop();
    if( b > 60 ){
        $(".navbar").addClass("is-scrolling");
    } else {
        $(".navbar").removeClass("is-scrolling");
    }
  });
  $.stellar({
    horizontalScrolling: false,
    verticalOffset: 50
  });

  $(':checkbox').radiocheck();
  $(':radio').radiocheck();
  $("img.lazy").show().lazyload({
    effect : "fadeIn"
  });


 var app = angular.module('App', ['ng-rails-csrf', 'ngResource']);

 var config = {
      ui: {
          flyout: 'top center',
          button_text: '',
          button_font: true,
          icon_font: true
        }
  }
  if($('#socialMedia').length){
     new Share("#socialMedia", config);
  }


});




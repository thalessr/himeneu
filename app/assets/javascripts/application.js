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
//= require jquery-migrate.min.js
//= require bootstrap/dist/js/bootstrap.min.js
//= require jquery.counterup.min.js
//= require angular/angular.min.js
//= require angular-resource/angular-resource.min.js
//= require angular-bootstrap-colorpicker/js/bootstrap-colorpicker-module.min.js
//= require angular-wysiwyg/dist/angular-wysiwyg.min.js
//= require app/app.js
//= require app/app.services.js
//= require app/controllers/customersController.js
//= require app/controllers/providersController.js
//= require app/controllers/providerSearchController.js
//= require app/controllers/estimatesController.js
//= require app/controllers/recommendationsController.js
//= require app/controllers/tagCloudController.js
//= require app/controllers/featureImageController.js
//= require ng-rails-csrf


function showFlashMessage(msg, type, seconds){

   $('.top-right').notify({
        message: { text: msg},
        fadeOut: {
            delay: seconds
        },
        type: type
      }).show();
}


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
  });


});




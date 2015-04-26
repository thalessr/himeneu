// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$( document ).ready(function() {
  'use strict';
	$(function () {

       $("[data-behaviour~='datepicker']").focus(function() {
         $(this).datetimepicker({


          });
      });

		});
  $( "#resposta" ).click(function() {
    $('#responseModal').modal('show');
  });
});




// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function remove_address(link){
	$(link).prev("input[type=hidden]").val("1");
	$(link).closest("#address").hide();
}
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $("#addresses").append(content.replace(regexp, new_id));
}

function showScore(){
   $('div#provider_rating').raty({
      readOnly: function() {
        return true;
      },
      score: function() {
        return $(this).attr('data-score');
      },
  });
}

$(document).ready(function(){
  $.fn.raty.defaults.path = "/assets";
  $.fn.raty.defaults.half_show = true;

  $('textarea').autosize();


$( "#estimate" ).click(function() {
  $('#estimatesModal').modal('toggle');
});

  $('#provider_form').bind('ajax:success', function(evt, data, status, xhr) {
  	$('#error_msg').remove();
     $('.bottom-right').notify({
        message: { text: xhr.getResponseHeader("X-Flash-Notice") },
        type: 'success'
      }).show();

      if (null !== data.slug) {
        window.location.href = "/providers/"+data.slug;
      }

   });
   $('#provider_form').bind('ajax:error', function(data, xhr, status) {

      var errors, errorText;

      errors = $.parseJSON(xhr.responseText);

      for ( var error in errors ) {
        errorText = "";
        if (typeof error !== "undefined" && typeof errors[error] !== "undefined"){
           errorText += error + ': ' + errors[error];
            var field = error.replace(':', "");
            $("#"+field).closest('div').addClass('has-error');
        }

      }

     $('.bottom-right').notify({
        message: { text: errorText},
        type: 'danger'
      }).show();

   });

  $('#rate').raty();
  showScore();

});

$(window).bind("load", function(){
  $.fn.raty.defaults.path = "/assets";
  $.fn.raty.defaults.half_show = true;
  $('div#score').raty({
      readOnly: function() {
        return true;
      },
      score: function() {
        return $(this).attr('data-score');
      }
  });

});












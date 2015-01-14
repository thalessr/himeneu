// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function remove_address(link){
	$(link).prev("input[type=hidden]").val("1");
	$(link).closest("#address").hide();
}
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $("#addresses").append(content.replace(regexp, new_id));
}

$(document).ready(function(){
  $('textarea').autosize();

  $('#provider_form').bind('ajax:success', function(event, xhr, status) {
  	$(this).animate({ height:'toggle'}, 'slow');
	  $(this).before(
        '<div class="alert alert-success alert-dismissable">'+
            '<button type="button" class="close" ' +
                    'data-dismiss="alert" aria-hidden="true">' +
                '&times;' +
            '</button>' +
            xhr.responseJSON.first_name + ','+ xhr.getResponseHeader("X-Flash-Notice")+
         '</div>');

   });
   $('#provider_form').bind('ajax:error', function(data, xhr, status) {
      var errors, errorText;

      errors = $.parseJSON(xhr.responseText);
      for ( error in errors ) {
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      }

      errorText += "</ul>";
     $(this).before(
        '<div class="alert alert-danger alert-dismissable">'+
            '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">' +
                '&times;' +
            '</button>' +
              errorText
            +
         '</div>');

   });


});
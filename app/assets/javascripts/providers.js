// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function remove_address(link){
	$(link).prev("input[type=hidden]").val("1");
	$(link).closest("#address").hide();
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
	 $('.container').append(xhr);
   });

   $('#add_address').click(function() {
   	    console.log("clicado");
	   	 $.ajax({
		    type: "GET",
		    url: "/build_address",
		    success: function(data){
		        console.log(data);
		        $('#addresses').append(data);
		    }
		 });
	});





});
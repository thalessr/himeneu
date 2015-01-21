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

  $('#provider_form').bind('ajax:success', function(evt, data, status, xhr) {
  	$('#error_msg').remove();
	  $(this).before(
        '<div class="alert alert-success alert-dismissable">'+
            '<button type="button" class="close" ' +
                    'data-dismiss="alert" aria-hidden="true">' +
                '&times;' +
            '</button>' +
            xhr.responseJSON.first_name +" " + xhr.responseJSON.last_name  + ', '+ xhr.getResponseHeader("X-Flash-Notice")+
         '</div>');

   });
   $('#provider_form').bind('ajax:error', function(data, xhr, status) {
      console.log(xhr);
      var errors, errorText;

      $('#error_msg').remove();

      errors = $.parseJSON(xhr.responseText);
      for ( error in errors ) {
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
        var field = error.replace(':', "");
        $("#"+field).animate({
          borderBottomColor: "red",
          borderLeftColor: "red",
          borderRightColor: "red",
          borderTopColor: "red"
        });
      }

      errorText += "</ul>";
     $(this).before(
        '<div id="error_msg" class="alert alert-danger alert-dismissable">'+
            '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">' +
                '&times;' +
            '</button>' +
              errorText
            +
         '</div>');

   });
  $('#rate').raty();


});

$(window).bind("load", function(){
  $('div#score').raty({
        readOnly: function() {
          return true;
        },
        score: function() {
          return $(this).attr('data-score');
        }

      });
});

var app = angular.module('App', ['ng-rails-csrf', 'ngResource']);

app.factory("Recommendation", function($resource) {
  return $resource("/providers/:id/recommendations");
});

app.controller("RecommendationCtrl", function($scope, Recommendation){

  var i = $('#comment').data("param");
  Recommendation.query({ id: i },function(data){
    $scope.recommendations = data;

  });

  $scope.save = function(recommendation) {
        $scope.recommendation.rating = $('input:hidden[name=score]').val();
        Recommendation.save({id:i},angular.copy(recommendation),function(data){
          $scope.recommendations.push(data);
          $scope.recommendation.title = '';
          $scope.recommendation.comment = '';
          $scope.recommendation.rating = '';
          $('input:hidden[name=score]').val('');
        }, function(error) {

          $scope.recommendation.title = error.data['title'][0];

        });

  };

});




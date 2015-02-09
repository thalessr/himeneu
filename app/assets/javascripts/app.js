'use strict';
var app = angular.module('App', ['ng-rails-csrf', 'ngResource']);

app.factory("CustomerSearch", function($resource) {
  return $resource("/customers/search?q=");
});

app.factory("Recommendation", function($resource) {
  return $resource("/providers/:id/recommendations");
});

app.factory("Search", function($resource) {
  return $resource("/providers/search?q=");
});

app.factory("Carousel", function($resource) {
  return $resource("/providers/carousel");
});

app.controller("CustomerCtrl", function($scope, CustomerSearch){
  CustomerSearch.query({q: ""}, function(data){
      $scope.customers = data;
    });

  $scope.search = function(q){
    if (q === null || q === ""){
       q = "";
    }

    CustomerSearch.query({q: $scope.q}, function(data){
      $scope.customers = data;
    });
  };

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

app.controller("SearchCtrl", function($scope, Search){
  $scope.loading = true;
  Search.query({q: ""}, function(data){
      $scope.providers = data;
      $scope.loading = false;
    });

  $scope.hasScore = function(value) {
    if (value > 0){
      showScore();
      return true;
    }else
      return false;
  };

  $scope.search = function(q){
    if (q === null || q === ""){
       q = "";
    }
    $scope.loading = true;
    Search.query({q: $scope.q}, function(data){
      $scope.providers = data;
      $scope.loading = false;
    });
  };

});

app.controller("CarouselCtrl",function($scope, Carousel){
  $scope.sliderReady = false;
  Carousel.query(function(data){
    $scope.slides = data;
    $scope.sliderReady = true;
  });
});
'use strict';
var app = angular.module('App', ['ng-rails-csrf', 'ngResource']);

app.factory("CustomerSearch", function($resource) {
  return $resource("/customers/search?q=");
});

app.factory("Recommendation", function($resource) {
  return $resource("/providers/:id/recommendations");
});

app.factory("Search", function($resource) {
  return $resource("/providers/search");
});

app.factory("Carousel", function($resource) {
  return $resource("/providers/carousel");
});

app.controller("CustomerCtrl", function($scope, CustomerSearch){
  CustomerSearch.query({q: ""}, function(data){
      $scope.customers = data ;
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

app.controller("SearchCtrl", function($scope, $http, Search){
  $scope.loading = true;
  $scope.providers = [];
  $scope.get = function(page){
    if(page===null){
      $scope.loading = false;
      return;
    }
    Search.get({q: $scope.q, page: page}, function(data){
      $scope.providers = data.items;
      $scope.total_pages = data.total_pages;
      $scope.current_page = data.current_page;
      $scope.previous_page = data.previous_page;
      $scope.next_page = data.next_page;
      $scope.loading = false;
    });
  };

  $scope.get(1);

  $scope.hasScore = function(value) {
    if (value > 0){
      showScore();
      return true;
    }else
      return false;
  };

  $scope.search = function(q){
    $scope.loading = true;
    $scope.get(1);
  };



  $scope.next = function(){
    $scope.loading = true;
    $scope.get($scope.next_page);
  };

   $scope.prev = function(){
    $scope.loading = true;
    $scope.get($scope.previous_page);
   };
});

app.controller("CarouselCtrl",function($scope, Carousel){
  $scope.sliderReady = false;
  Carousel.query(function(data){
    $scope.slides = data;
    $scope.sliderReady = true;
  });
});



app.directive('whenScrolled', function() {
    return function(scope, elm, attr) {
        var raw = elm[0];

        elm.bind('scroll', function() {
            if (raw.scrollTop + raw.offsetHeight >= raw.scrollHeight) {
                scope.$apply(attr.whenScrolled);
            }
        });
    };
});


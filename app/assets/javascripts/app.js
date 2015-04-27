'use strict';
var app = angular.module('App', ['ng-rails-csrf', 'ngResource', 'colorpicker.module', 'wysiwyg.module']);

app.factory("CustomerSearch", ["$resource", function($resource) {
  return $resource("/customers/search?q=");
}]);

app.factory("Recommendation", ["$resource", function($resource) {
  return $resource("/providers/:id/recommendations");
}]);

app.factory("Search", ["$resource", function($resource) {
  return $resource("/providers/search");
}]);

app.factory("Carousel", ["$resource", function($resource) {
  return $resource("/providers/carousel");
}]);

app.factory("Estimate", ["$resource", function($resource) {

  return $resource('/estimates/:id', null,
    {
        'update': { method:'PUT' }
    });

}]);

app.factory 'CustomerShow', ['$resource', ($resource) ->
  $resource '/customers/:id', id: '@id'
]

app.controller ('CostumerShowCtrl', ['$scope', 'CustomerShow', function($scope, CustomerShow){
  $scope.customer = CustomerShow.query();
}
]

app.controller("CustomerCtrl", ["$scope","CustomerSearch", function($scope, CustomerSearch){
  $scope.loading = true;
  $scope.customers = [];
  $scope.get = function(page){
    if(page===null){
      $scope.loading = false;
      return;
    }
    CustomerSearch.get({q: $scope.q, page: page}, function(data){
      $scope.customers = data.items;
      $scope.total_pages = data.total_pages;
      $scope.current_page = data.current_page;
      $scope.previous_page = data.previous_page;
      $scope.next_page = data.next_page;
      $scope.loading = false;
    });
  };

  $scope.get(1);

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

  $scope.setPage = function(n) {
    if (n > 0 && n <= $scope.total_pages) {
      $scope.get(n);
    }
  };

  $scope.range = function() {
    var rangeSize = 5;
    var ret = [];
    var start;

    if ( rangeSize > $scope.total_pages ){
        rangeSize = $scope.total_pages;
    }

    start = $scope.current_page;
    if ( start > $scope.total_pages-rangeSize ) {
      start = $scope.total_pages - rangeSize;
    }

    for (var i = start; i < start + rangeSize; i++) {
      ret.push(i);
    }
    return ret;
  };

}]);


app.controller("RecommendationCtrl", ["$scope","Recommendation", function($scope, Recommendation){

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

}]);

app.controller("SearchCtrl", ["$scope","Search", function($scope, Search){
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

  $scope.setPage = function(n) {
    if (n > 0 && n <= $scope.total_pages) {
      $scope.get(n);
    }
  };

   $scope.range = function() {
      var rangeSize = 5;
      var ret = [];
      var start;

      if ( rangeSize > $scope.total_pages ){
          rangeSize = $scope.total_pages;
      }

      start = $scope.current_page;
      if ( start > $scope.total_pages-rangeSize ) {
        start = $scope.total_pages - rangeSize;
      }

      for (var i = start; i < start + rangeSize; i++) {
        ret.push(i);
      }
      return ret;
   };
}]);

app.controller("CarouselCtrl", ["$scope","Carousel",function($scope, Carousel){
  $scope.sliderReady = false;
  Carousel.query(function(data){
    $scope.slides = data;
    $scope.sliderReady = true;
  });
}]);

/**
 * Estimate Controller
 */
app.controller("EstimateCtrl", ["$scope","Estimate",function($scope, Estimate){


  $scope.save = function() {
    $scope.estimate.provider_id = $('#estimatesModal').data("param");
    Estimate.save(angular.copy($scope.estimate),function(data){
      $('#estimatesModal').modal('hide');
      location.reload();
    }, function(error) {
       console.log(error);
    });
  };

  $scope.update = function() {
    $scope.estimate.customer_id = $('#responseModal').data("param");
    Estimate.update({ id: $scope.estimate.customer_id },angular.copy($scope.estimate),function(data){
      $('#responseModal').modal('hide');
      location.reload();
    }, function(error) {
       console.log(error);
    });
  };

}]);




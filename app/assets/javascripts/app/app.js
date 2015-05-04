var app = angular.module('App', ['ng-rails-csrf', 'ngResource', 'colorpicker.module', 'wysiwyg.module']);







app.controller("CarouselCtrl", ["$scope","Carousel",function($scope, Carousel){
  $scope.sliderReady = false;
  Carousel.query(function(data){
    $scope.slides = data;
    $scope.sliderReady = true;
  });
}]);






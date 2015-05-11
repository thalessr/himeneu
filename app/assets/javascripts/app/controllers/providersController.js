app.controller("ProvidersCtrl", ["$scope","Provider",function($scope, Provider){
  $scope.sliderReady = false;
  Provider.query(function(data){
    $scope.slides = data;
    $scope.sliderReady = true;
  });
  $scope.provider = new Provider();

   $scope.save = function() {
     Estimate.save(angular.copy($scope.provider),function(data){
     }, function(error) {
       console.log(error);
     });
   };


}]);

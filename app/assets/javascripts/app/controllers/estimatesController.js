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

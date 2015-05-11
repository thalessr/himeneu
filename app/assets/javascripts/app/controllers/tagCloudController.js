app.controller("TagCloudCtrl", ["$scope","TagCloud",function($scope, TagCloud){
  TagCloud.query(function(data){
    $scope.tags = data;
  });
}]);

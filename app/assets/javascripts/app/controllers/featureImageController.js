app.controller("FeatureImageCtrl", ["$scope","FeatureImage",function($scope, FeatureImage){
  var provider_id = $("#gallery").data("param");

  /**
   * Return a list of images from a given provider
   * @param  {[type]} data){  $scope.images [description]
   * @return {[type]}         [description]
   */
  FeatureImage.query({provider: provider_id},function(data){
    $scope.images = data;
  });

  /**
  * Delete a given image
  * @return {[type]} [description]
  */
 $scope.delete = function(index) {
    var img = $scope.images[index];

    FeatureImage.delete({id: img.id},function(data){
       $scope.images.splice( index, 1 );
    }, function(error) {
       console.log(error);
    });
  };


}]);

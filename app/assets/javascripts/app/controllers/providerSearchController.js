app.controller("SearchCtrl", ["$scope","Search","BestSeller", function($scope, Search, BestSeller){
  $scope.loading = true;
  $scope.providers = [];
  $scope.get = function(page){
    if(page===null){
      $scope.loading = false;
      return;
    }
    Search.get({q: $scope.q, page: page, sort: $scope.order}, function(data){
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

  $scope.sort = function(q){
    $scope.loading = true;
    $scope.get(1);
  };

  $scope.setPage = function(n) {
    if (n > 0 && n <= $scope.total_pages) {
      $scope.get(n);
    }
  };

  BestSeller.query(function(data){
    $scope.bestSellers = data;
  });

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

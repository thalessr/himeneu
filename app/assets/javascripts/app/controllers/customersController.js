app.controller("CustomerCtrl", ["$scope","CustomerSearch", "Customer", function($scope, CustomerSearch, Customer){
  $scope.loading = true;
  $scope.customers = [];
  // $scope.get = function(page){
  //   if(page===null){
  //     $scope.loading = false;
  //     return;
  //   }
  //   CustomerSearch.get({q: $scope.q, page: page}, function(data){
  //     $scope.customers = data.items;
  //     $scope.total_pages = data.total_pages;
  //     $scope.current_page = data.current_page;
  //     $scope.previous_page = data.previous_page;
  //     $scope.next_page = data.next_page;
  //     $scope.loading = false;
  //   });
  // };

  var slug = $('#showCustomer').data("param");
  Customer.get({ id: slug },function(data){
     $scope.customer = data;
     $scope.full_name = data.first_name + " " + data.last_name
  });

  // $scope.get(1);

  // $scope.search = function(q){
  //   $scope.loading = true;
  //   $scope.get(1);
  // };

  // $scope.next = function(){
  //   $scope.loading = true;
  //   $scope.get($scope.next_page);
  // };

  //  $scope.prev = function(){
  //   $scope.loading = true;
  //   $scope.get($scope.previous_page);
  //  };

  // $scope.setPage = function(n) {
  //   if (n > 0 && n <= $scope.total_pages) {
  //     $scope.get(n);
  //   }
  // };

  //  $scope.range = function() {
  //     var rangeSize = 5;
  //     var ret = [];
  //     var start;

  //     if ( rangeSize > $scope.total_pages ){
  //         rangeSize = $scope.total_pages;
  //     }

  //     start = $scope.current_page;
  //     if ( start > $scope.total_pages-rangeSize ) {
  //       start = $scope.total_pages - rangeSize;
  //     }

  //     for (var i = start; i < start + rangeSize; i++) {
  //       ret.push(i);
  //     }
  //     return ret;
  //  };

}]);


// app.controller("CustumerCtrl", ["$scope","Customer",function($scope, Customer){
//    //slug = customer.slug
//   var slug = $('#showCustomer').data("param");
//   Customer.get({ id: slug },function(data){
//      $scope.customer = data;
//      $scope.full_name = data.first_name + " " + data.last_name
//   });
// }]);

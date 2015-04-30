
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

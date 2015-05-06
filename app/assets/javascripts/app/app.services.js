
app.factory("CustomerSearch", ["$resource", function($resource) {
  return $resource("/customers/search?q=");
}]);

app.factory("Recommendation", ["$resource", function($resource) {
  return $resource("/recommendations");
}]);

app.factory("Search", ["$resource", function($resource) {
  return $resource("/providers/search");
}]);

app.factory("TagCloud", ["$resource", function($resource) {
  return $resource("/providers/cloud");
}]);

app.factory("Provider", ["$resource", function($resource) {
  return $resource("/providers/:id");
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

app.factory("BestSeller", ["$resource", function($resource) {
  return $resource("/providers/bestSeller");
}]);


app.factory("Customer", ["$resource", function($resource) {
  return $resource("/customers/:id");
}]);

/**
 * Use it to upload and delete those adicional images
 * located at providers' gallery
 */
app.factory("FeatureImage", ["$resource", function($resource) {
  return $resource("/feature_images/:id");
}]);

// app.config([ '$stateProvider', '$urlRouterProvider', '$locationProvider',
//             function($stateProvider, $urlRouterProvider, $locationProvider) {
//     $urlRouterProvider

//       .when('api/v1/providers', '/providers')


//         // If the url is ever invalid, e.g. '/asdf', then redirect to '/' aka the home state
//         .otherwise('/');




//         $stateProvider

//         //////////
//         // Home //
//         //////////

//         .state("providers", {

//           // Use a url of "/" to set a states as the "index".
//           url: "/providers",

//           // Example of an inline template string. By default, templates
//           // will populate the ui-view within the parent state's template.
//           // For top level states, like this one, the parent template is
//           // the index.html file. So this template will be inserted into the
//           // ui-view within index.html.
//           template: '<p class="lead">Welcome to the UI-Router Demo</p>' +
//             '<p>Use the menu above to navigate. ' +
//             'Pay attention to the <code>$state</code> and <code>$stateParams</code> values below.</p>' +
//             '<p>Click these links—<a href="#/c?id=1">Alice</a> or ' +
//             '<a href="#/user/42">Bob</a>—to see a url redirect in action.</p>'

//         });


// }]);

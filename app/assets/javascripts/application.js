/*
= require oxymoron/underscore
= require oxymoron/angular
= require oxymoron/angular-resource
= require oxymoron/angular-cookies
= require oxymoron/angular-ui-router
= require oxymoron/ng-notify
= require oxymoron
= require_self
= require_tree ./controllers
= require ammap
= require wow.min
= require jquery3
= require jquery_ujs
= require ng-file-upload
= require angularjs-toaster
= require ngDialog
= require angular-truncate-2
= require_tree ./configs
= require_tree ./directives
*/
var app = angular.module('app', ['ui.router','oxymoron', 'ngDialog', 'ngFileUpload']);

app.config(['$stateProvider', function ($stateProvider) {
  $stateProvider.rails()
}])

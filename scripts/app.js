'use strict';

var app = angular.module('EjemploAngularjs', [
	'ui.router'
])


app.config(function($stateProvider, $urlRouterProvider){

	$stateProvider
		.state('home', {
			url: '/home',
			templateUrl: 'views/formulario.html',
			controller: 'HomeController',
			controllerAs: 'home'
		});

	$urlRouterProvider.otherwise('/home');

});
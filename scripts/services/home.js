'use strict';

app.factory('HomeFactory', function($http){

	var url = 'http://api.geonames.org/search?q&username=ceroz03';

	var HomeFactory = {

		getUsers: function(){
			return $http.get(url).success(function(data){
				return data;
			})
			.error(function(err){
				console.log(err);
			})
		},

		createUser: function(user){

			return $http.post(path, user).success(function(data){
				return data;
			})
			.error(function(err){
				console.log(err)
			})


		}

	};

	return HomeFactory

});
app.controller 'UsersSessionsCtrl', [
  '$scope', '$http', '$rootScope', 'action', '$location',
  ($scope, $http, $rootScope, action, $location) ->

    ctrl = this

    $scope.commit = ->

      $http.post('/users/sign_in.json',  ctrl.data).then((res)->  
        $location.url Routes.root_path()
      ).catch ()->
    
    return
]

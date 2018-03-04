app.controller 'PacksCtrl', [
  '$scope', 'action', 'Pack',
($scope, action, Pack) -> 

    ctrl = this
    action 'show', (params) ->
      ctrl.pack = Pack.get({id: params.id})
      console.log ctrl.pack
    return
]
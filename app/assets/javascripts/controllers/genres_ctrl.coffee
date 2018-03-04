app.controller 'GenresCtrl', [
  '$scope', 'Genre', 'action',  
  ($scope, Genre, action) -> 

    ctrl = this
    action 'index', () ->
      ctrl.genres = Genre.query()

    action 'show', (params) ->
      ctrl.genre = Genre.get({id: params.id})
      console.log ctrl.genre
    return
]
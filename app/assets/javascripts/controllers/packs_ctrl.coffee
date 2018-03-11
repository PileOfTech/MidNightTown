app.controller 'PacksCtrl', [
  '$scope', '$http', 'action', 'Pack',
($scope, $http, action, Pack) -> 

    ctrl = this
        
    action 'show', (params) ->
      current = 0
      $scope.date = ''
      $scope.watches = 0

      $scope.create = ()->
        console.log 'click'

      increment = (image_id)->
        $http.post("/images", {image_id: image_id}).then((response) ->
          $scope.watches = response["data"].watches
        )

      Next = ()->
        if current + 1 <= ctrl.images.length - 1 then next = current + 1 else next = 0
        image = ctrl.images[next]
        setModal(image)     
        $scope.watches = image.image.watches
        $scope.date = Date.parse(image.created_at)
        current = next

      Last = ()->
        if current + 1 < ctrl.images.length - 1 then last = current + 1 else last = 0
        image = ctrl.images[last]
        setModal(image)      
        $scope.watches = image.image.watches
        $scope.date = Date.parse(image.created_at)
        current = last
      
      $scope.modal = (index)->
        current = index
        image = ctrl.images[index]
        setModal(image)
        $scope.watches = ctrl.images[index].watches
        $scope.date = Date.parse(ctrl.images[index].created_at)        
        return

      setModal = (image)->
        url = image.image.url
        $('#img').attr("src", url)
        width = document.getElementById("img").width
        height = document.getElementById("img").height
        delta =  height / 500
        newW = width /delta
        $('.modal').css('width', newW)
        $('body').css('overflow-y', 'hidden')
        scrolled = $(window).scrollTop()
        $('.modal-back').css('top', scrolled)
        $('.modal-back').addClass('open')
        increment(image.id)

      $('.close').click ()->
        $('.modal-back').removeClass('open')
        $('body').css('overflow-y', 'auto')
        
      $('.arrow-side.left').click ()->
        Last()
      $('.arrow-side.right').click ()->
        Next()

      $(window).keydown(( event ) ->
        if($(".modal-back").hasClass("open"))
          if(event.which == 39)
            Next()
          if(event.which == 37)
            Next()  
      )

      pack = Pack.get {id: params.id}, (res)->
        ctrl.images = res.images
        console.log ctrl.images[0]
       

    return
]
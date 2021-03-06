app.controller 'PacksCtrl', [
  '$scope', '$http', 'action', 'Pack', 'Image', 'Upload'
($scope, $http, action, Pack, Image, Upload) -> 

    ctrl = this
        
    action 'show', (params) ->
      current = 0
      $scope.date = ''
      $scope.watches = 0

      $scope.remove = (id)->
        scrolled = $(window).scrollTop()
        $('.modal-remove').addClass('open')
        $('body').css('overflow-y', 'hidden')
        $('.modal-remove').css('top', scrolled)  
        $('.yes').click ()->
          Image.destroy(id: id)
          $('.modal-remove').removeClass('open')
          $('body').css('overflow-y', 'auto') 
          pack = Image.get {id: params.id}, (res)->
            ctrl.images = res.images
        $('.no').click ()->
          $('.modal-remove').removeClass('open')
          $('body').css('overflow-y', 'auto') 


      $scope.create = () ->
        Upload.upload(
          url: '/download'
          data: {file: $scope.file, pack_id: params.id}
        ).then (res)->
          $('.modal-form-back').removeClass('open')
          $('body').css('overflow-y', 'auto')
          pack = Pack.get {id: params.id}, (res)->
            ctrl.images = res.images

      $scope.add = ()->
        scrolled = $(window).scrollTop()
        $('.modal-form-back').addClass('open')
        $('body').css('overflow-y', 'hidden')
        $('.modal-form-back').css('top', scrolled)        

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
        
        if($(window).width() > 400)
          modalH = 500
        else
          modalH = 230

        delta =  height / modalH
        newW = width /delta

        if($(window).width() <= 400)
          if(modalH >= newW)
            modalH = modalH*2
            newW = newW*2
            $('.modal').css('height', modalH)
            $('.modal').css('margin-top', 60+'px')
          else
            modalH = 230
            $('.modal').css('height', modalH)
            $('.modal').css('margin-top', 150+'px')
            
        
        $('.modal').css('width', newW)
        $('body').css('overflow-y', 'hidden')
        scrolled = $(window).scrollTop()
        $('.modal-back').css('top', scrolled)
        $('.modal-back').addClass('open')
        increment(image.id)

      $('.close').click ()->
        $('.modal-back').removeClass('open')
        $('body').css('overflow-y', 'auto')
      
      $('.cl-form').click ()->
        $('.modal-form-back').removeClass('open')
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
       

    return
]
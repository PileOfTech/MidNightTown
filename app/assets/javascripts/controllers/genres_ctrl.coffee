app.controller 'GenresCtrl', [
  '$scope', 'Genre', 'Pack', 'action', '$http', 'Upload' 
  ($scope, Genre, Pack, action, $http, Upload) -> 
    angular.element(document).ready(() ->
      new WOW(  {
        boxClass:     'wow',
        offset:       50,          
        mobile:       true,       
        live:         true,       
        animateClass: 'animated',
        scrollContainer: null
      }).init()
    )
    ctrl = this
    $scope.notMobile
    if($(window).width() > 800)
      $scope.notMobile = true
    else
      $scope.notMobile = false
    
    $('.close').click ()->
      $('.modal-back-main').removeClass('open')
      $('body').css('overflow-y', 'auto')


    $scope.modal = ()->
      scrolled = $(window).scrollTop()
      $('.modal-back-main').addClass('open')
      $('body').css('overflow-y', 'hidden')
      $('.modal-back-main').css('top', scrolled)

    action 'index', () ->
      $(window).bind('scroll', (e)->
          parallaxScroll();
      )
      lastScrollTop = 0


      parallaxScroll = ()->
        if($(window).width() > 1000)
          scrolled = $(window).scrollTop()
          $('#town1').css('top',(0-(scrolled*0.6))+'px')
          $('#town2').css('top',(0-(scrolled*0.3))+'px')
          $('#town3').css('top',(0-(scrolled*0.1))+'px')
          $('#back').css('top',(0-(scrolled*0.6))+'px')
        else
          scrolled = $(window).scrollTop()
          $('#town1').css('top',(0-(scrolled*0.4))+'px')
          $('#town2').css('top',(0-(scrolled*0.3))+'px')
          $('#town3').css('top',(0-(scrolled*0.1))+'px')
          $('#back').css('top',(0-(scrolled*0.4))+'px')
        
        # if($(window).width() > 1000)
        #   if(scrolled > lastScrollTop)
        #     $('.genres').removeClass('return')
        #     if(scrolled > 250)
        #       $('.genres').addClass('top')  
        #   if(scrolled < lastScrollTop)
        #     if(scrolled <= 250)
        #       $('.genres').removeClass('top2')
        #       $('.genres').addClass('return')
        #     if(scrolled <= 100)
        #       $('.genres').removeClass('top')              
        lastScrollTop = scrolled
      
      $scope.remove = (id)->
        scrolled = $(window).scrollTop()
        $('.modal-remove').addClass('open')
        $('body').css('overflow-y', 'hidden')
        $('.modal-remove').css('top', scrolled)  
        $('.yes').click ()->
          Genre.destroy(id: id)
          $('.modal-remove').removeClass('open')
          $('body').css('overflow-y', 'auto') 
        $('.no').click ()->
          $('.modal-remove').removeClass('open')
          $('body').css('overflow-y', 'auto') 
        ctrl.genres = Genre.query()

      $scope.create = () ->
        Upload.upload(
          url: '/genres'
          data: {name: $scope.name, file: $scope.file}
        ).then (res)->
          $('.modal-back-main').removeClass('open')
          $('body').css('overflow-y', 'auto')
          ctrl.genres = Genre.query()

      ctrl.genres = Genre.query()

    action 'show', (params) ->
      ctrl.genre = Genre.get({id: params.id})
      $scope.create = () ->
        Upload.upload(
          url: '/packs'
          data: {data: ctrl.data, genre_id: params.id}
        ).then (res)->
          $('.modal-back-main').removeClass('open')
          $('body').css('overflow-y', 'auto')
          ctrl.genre = Genre.get({id: params.id})

      $scope.remove = (id)->
        scrolled = $(window).scrollTop()
        $('.modal-remove').addClass('open')
        $('body').css('overflow-y', 'hidden')
        $('.modal-remove').css('top', scrolled)  
        $('.yes').click ()->
          Pack.destroy(id: id)
          $('.modal-remove').removeClass('open')
          $('body').css('overflow-y', 'auto') 
        $('.no').click ()->
          $('.modal-remove').removeClass('open')
          $('body').css('overflow-y', 'auto') 
        ctrl.genre = Genre.get({id: params.id})


    action 'price_list', () ->

    action 'contacts', () ->
      
    return
]
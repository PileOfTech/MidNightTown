app.controller 'GenresCtrl', [
  '$scope', 'Genre', 'action', '$http', 'Upload' 
  ($scope, Genre, action, $http, Upload) -> 
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
          scrolled = $(window).scrollTop()
          $('#town1').css('top',(0-(scrolled*0.4))+'px')
          $('#town2').css('top',(0-(scrolled*0.3))+'px')
          $('#town3').css('top',(0-(scrolled*0.1))+'px')
          $('#back').css('top',(0-(scrolled*0.4))+'px')
          if(scrolled > lastScrollTop)
            $('.genres').removeClass('return')
            if(scrolled > 250)
              $('.genres').addClass('top')  
          if(scrolled < lastScrollTop)
            if(scrolled <= 250)
              $('.genres').removeClass('top2')
              $('.genres').addClass('return')
            if(scrolled <= 100)
              $('.genres').removeClass('top')                
          lastScrollTop = scrolled
      
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
      console.log ctrl.genre
      $scope.create = () ->
        Upload.upload(
          url: '/packs'
          data: {data: ctrl.data, genre_id: params.id}
        ).then (res)->
          $('.modal-back-main').removeClass('open')
          $('body').css('overflow-y', 'auto')
          ctrl.genre = Genre.get({id: params.id})

    action 'price_list', () ->

    action 'contacts', () ->
      
    return
]
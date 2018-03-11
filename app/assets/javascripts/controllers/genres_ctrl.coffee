app.controller 'GenresCtrl', [
  '$scope', 'Genre', 'action', '$http' 
  ($scope, Genre, action, $http) -> 
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
    action 'index', () ->
      $(window).bind('scroll', (e)->
          parallaxScroll();
      )
      lastScrollTop = 0

      $('.close').click ()->
        $('.modal-back-main').removeClass('open')
        $('body').css('overflow-y', 'auto')


      $scope.modal = ()->
        $('.modal-back-main').addClass('open')
        scrolled = $(window).scrollTop()
        $('.modal-back-main').css('top', scrolled)
        $('body').css('overflow-y', 'hidden')

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
        $http.post("/genres", {name: $scope.name, file: $scope.file}).then((response) ->
          
        )

      ctrl.genres = Genre.query()

    action 'show', (params) ->
      ctrl.genre = Genre.get({id: params.id})

    action 'price_list', () ->

    action 'contacts', () ->
      
    return
]
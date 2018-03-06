app.controller 'GenresCtrl', [
  '$scope', 'Genre', 'action',  
  ($scope, Genre, action) -> 
    angular.element(document).ready(() ->
      new WOW(  {
        boxClass:     'wow',
        offset:       0,          
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
      parallaxScroll = ()->
          scrolled = $(window).scrollTop()
          $('#town1').css('top',(0-(scrolled*0.4))+'px')
          $('#town2').css('top',(0-(scrolled*0.3))+'px')
          $('#town3').css('top',(0-(scrolled*0.1))+'px')
          $('#back').css('top',(0-(scrolled*0.4))+'px')
          if(scrolled > lastScrollTop)
            $('.genres').removeClass('return')
            if(scrolled > 200)
              $('.genres').addClass('top')
            # if(scrolled >= 200)
            #   $('.genres').addClass('top2')   
          if(scrolled < lastScrollTop)
            if(scrolled <= 200)
              $('.genres').removeClass('top2')
              $('.genres').addClass('return')
            if(scrolled <= 100)
              $('.genres').removeClass('top')                
          lastScrollTop = scrolled

      ctrl.genres = Genre.query()

    action 'show', (params) ->
      ctrl.genre = Genre.get({id: params.id})
    return
]
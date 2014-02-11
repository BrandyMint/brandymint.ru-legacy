#= require jquery/jquery.min
#= require jquery.role/lib/jquery.role
#= require bootstrap
#= require modernizr/modernizr

window.App ||= {}

$ ->
  $('@clickable-block').on 'click', () ->
    url = $(@).data('href')
    window.location.href = url

  App.navbarToggleBtn.on 'click', () ->
    App.toggleMenu()

  lastScrollTop = 0
  if App.isMobile == true
    App.appNavbar.addClass('navbar-mobile-device')
    App.navbarMenuBlock.removeClass 'active'
  else
    unless $('body').hasClass('hide-navbar-menu')
      App.toggleMenu(App.navbarToggleBtn, App.navbarMenuBlock)
    $(window).on 'scroll', (event) ->
      st = $(this).scrollTop()
      if st > 100
        if st >= lastScrollTop || st == 0
          App.hideNavbar(st, App.coverImageHeight)
          # downscroll code
        else
          App.showNavbar(st, App.coverImageHeight)
          # upscroll code
      else
        #App.hideNavbar()
      lastScrollTop = st

((app) ->
  userAgent = navigator.userAgent
  android = userAgent.match(/(Android)/g)
  ios = userAgent.match(/(iPhone)/g) || userAgent.match(/(iPad)/g)
  if ios || android || $(window).width() <= 640
    app.isMobile = true
  else
    app.isMobile = false
)(window.App ||= {})

((app) ->
  app.appNavbar = $('@application-navbar')
  app.hideNavbar = (st, coverHeight) ->
    setTimeout(( ->
      app.appNavbar.addClass('transparent')
    ), 200)
  app.showNavbar = (st, coverHeight) ->
    setTimeout(( ->
      app.appNavbar.removeClass('transparent')
      if coverHeight? && st > coverHeight
        app.appNavbar.addClass('navbar-white')
      else if st < coverHeight
        app.appNavbar.removeClass('navbar-white')
    ), 200)
)(window.App ||= {})

((app) ->
  app.coverImageHeight = $('@cover-image').height()
  app.navbarMenuBlock = $('@navbar-menu')
  app.navbarToggleBtn = $('@app-nav-toggle-button')
  app.toggleMenu = (btn = app.navbarToggleBtn, menu = app.navbarMenuBlock) ->
    btn.toggleClass 'app-nav-toggle-active'
    #btn.toggleClass 'app-nav-toggle-inactive'
    menu.toggleClass('active')
)(window.App ||= {})

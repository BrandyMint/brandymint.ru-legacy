#= require jquery/jquery.min
#= require jquery.role/lib/jquery.role
#= require bootstrap
#= require jquery-waypoints/waypoints
#= require modernizr/modernizr
#= require jReject/js/jquery.reject

window.App ||= {}

$ ->
  if App.isMobile == true
    App.appNavbar.addClass('navbar-mobile-device')
    App.navbarMenuBlock.removeClass 'active'
  else
    #unless $('body').hasClass('hide-navbar-menu')
    #  App.navbarMenuBlock.addClass('navbar-transitions')
    #  App.toggleMenu(App.navbarToggleBtn, App.navbarMenuBlock)
    lastScrollTop = 0
    App.navbarScrollEnabled ||= true
    $(window).on 'scroll', (event) ->
      st = $(this).scrollTop()
      if st > 100
        if st >= lastScrollTop || st == 0
          App.hideNavbar(st, App.coverImageHeight)
          # downscroll code
        else
          if App.navbarScrollEnabled == true
            App.showNavbar(st, App.coverImageHeight)
            # upscroll code
      else
        #App.hideNavbar()
      lastScrollTop = st

  $('@clickable-block').on 'click', () ->
    url = $(@).data('href')
    window.location.href = url

  App.navbarToggleBtn.on 'click', () ->
    App.toggleMenu()

((app) ->
  $(document).ready ->
    $.reject
      reject:
        msie: 8
      display: [
        "chrome"
        "firefox"
        "safari"
        "opera"
      ]
      header: "Вы используете устаревший браузер"
      paragraph1: "Вы пользуетесь устаревшим браузером, который не поддерживает современные веб-стандарты."
      paragraph2: "Чтобы использовать все возможности сайта, загрузите и установите один из этих браузеров:"
      closeMessage: ""
      closeLink: "Закрыть это сообщение"
      closeCookie: true
      imagePath: "/images/"
)(window.App ||= {})


((app) ->
  $(document).ready ->
    $('@project-waypoint-start').waypoint (direction) ->
      if app.navbarScrollEnabled == true
        app.secondaryNavbar.find('[data-link-project]').removeClass 'active'
        project = $(@).data('project')
        app.secondaryNavbar.find('[data-link-project='+project+']').addClass('active')
    $('@project-waypoint-end').waypoint (direction) ->
      app.secondaryNavbar.find('[data-link-project]').removeClass 'active'

    $("@project-link").on 'click', (e) ->
      e.preventDefault()
      $("@project-link").removeClass 'active'
      $(@).addClass 'active'
      project = $(@).data('link-project')
      projectBlock = $('[data-project="'+project+'"]')
      top = projectBlock.position().top
      currentScrollTop = $('body').scrollTop()
      if top < currentScrollTop
        top = top - 2
        direction = 'Down'
      else
        top = top + 2
        direction = 'Up'
      animationClass = 'animated fadeIn'+direction
      $('body')
        .scrollTop(top)
      projectBlock
        .addClass animationClass
        .one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', () ->
          $(@).removeClass animationClass
)(window.App ||= {})

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
  app.secondaryNavbar = $('@secondary-navbar')
  app.hideNavbar = (st, coverHeight) ->
    if app.navbarScrollEnabled == true
      setTimeout(( ->
        app.appNavbar.addClass('transparent')
        app.secondaryNavbar.addClass('secondary-navbar-top')
      ), 200)
  app.showNavbar = (st, coverHeight) ->
    setTimeout(( ->
      app.appNavbar.removeClass('transparent')
      app.secondaryNavbar.removeClass('secondary-navbar-top')
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
    menu.toggleClass('active')
    $('body, html').toggleClass('not-scrollable')
    app.navbarScrollEnabled = !app.navbarScrollEnabled
    if app.navbarScrollEnabled
      # on hiding
      setTimeout(( ->
        menu.toggleClass('navbar-transitions')
      ), 600)
    else
      # on showing
      menu.toggleClass('navbar-transitions')

)(window.App ||= {})

((app) ->
  app.truncate = (string, size=100) ->
    return string if string.length < size
    words_array = $.trim(string).substring(0, size).split(' ')
    new_string = words_array.join(" ") + "&hellip;"
    if new_string.length > size
      words_array.slice(0, -1).join(" ") + "&hellip;"
    else
      new_string
)(window.App || = {})


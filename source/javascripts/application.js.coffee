#= require jquery/jquery.min
#= require jquery.role/lib/jquery.role
#= require bootstrap
#= require modernizr/modernizr

$ ->
  #$(".collapse").collapse()
  userAgent = navigator.userAgent
  android = userAgent.match(/(Android)/g)
  ios = userAgent.match(/(iPhone)/g) || userAgent.match(/(iPad)/g)
  if ios || android || $(window).width() <= 640
    @isMobile = true
  else
    @isMobile = false

  $('@clickable-block').on 'click', () ->
    url = $(@).data('href')
    console.log url
    window.location.href = url

  coverImageHeight = $('@cover-image').height()

  navbarMenuBlock = $('@navbar-menu')
  navbarToggleBtn = $('@app-nav-toggle-button')
  navbarToggleBtn.on 'click', () ->
    $(@).toggleClass 'app-nav-toggle-active'
    navbarMenuBlock.toggleClass('active')

  lastScrollTop = 0
  if @isMobile == true
    @appNavbar.addClass('navbar-mobile-device')
    navbarMenuBlock.removeClass 'active'
  else
    unless $('body').hasClass('hide-navbar-menu')
       navbarToggleBtn.addClass 'app-nav-toggle-active'
       navbarMenuBlock.addClass('active')
    $(window).on 'scroll', (event) ->
      st = $(this).scrollTop()
      if st > 100
        if st >= lastScrollTop || st == 0
          @hideNavbar(st, coverImageHeight)
          # downscroll code
        else
          @showNavbar(st, coverImageHeight)
          # upscroll code
      else
        #@hideNavbar()
      lastScrollTop = st

@appNavbar = $('@application-navbar')

@hideNavbar = (st, coverHeight) ->
  setTimeout(( ->
    @appNavbar.addClass('transparent')
  ), 200)

@showNavbar = (st, coverHeight) ->
  setTimeout(( ->
    @appNavbar.removeClass('transparent')
    if coverHeight? && st > coverHeight
      @appNavbar.addClass('navbar-white')
    else if st < coverHeight
      @appNavbar.removeClass('navbar-white')
  ), 200)


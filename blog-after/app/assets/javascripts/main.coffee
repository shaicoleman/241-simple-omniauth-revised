$(document).on 'ready page:load', ->     # execute on DOM Ready, compatible with Turbolinks
  $(".oauthpopup").oauthpopup
    callback: ->
      window.location.reload()

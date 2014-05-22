window.fbAsyncInit = ->
  FB.init(
    appId: Meteor.settings.public.facebook.appId
    xfbml: true
  )


Session.setDefault("indentationCharacter", "space")
Session.setDefault("indentationCount", 2)

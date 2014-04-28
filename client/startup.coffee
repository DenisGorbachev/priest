window.fbAsyncInit = ->
  FB.init(
    appId: Meteor.settings.public.facebook.appId
    xfbml: true
  )
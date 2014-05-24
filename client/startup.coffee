window.fbAsyncInit = ->
  FB.init(
    appId: Meteor.settings.public.facebook.appId
    xfbml: true
  )

if not ReactiveStore.get("indentationCharacter")
  ReactiveStore.set("indentationCharacter","space")
if not ReactiveStore.get("spaceIndentationCount")
  ReactiveStore.set("spaceIndentationCount","2")
if not ReactiveStore.get("tabIndentationCount")
  ReactiveStore.set("tabIndentationCount", "1")

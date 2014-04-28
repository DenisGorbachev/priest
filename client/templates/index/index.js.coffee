Template.index.helpers
#  helper: ->

Template.index.rendered = ->
  if typeof(gapi) isnt "undefined" # loaded
    $(@findAll(".g-plusone")).each (index, element) ->
      gapi.plusone.render(element, $(element).data())
  if typeof(FB) isnt "undefined" # loaded
    $(@findAll(".fb-button")).each (index, element) ->
      FB.XFBML.parse(element.parentNode)
  if typeof(twttr) isnt "undefined"
    $(@findAll(".twitter-share-button")).each (index, element) ->
      element.setAttribute("data-url", location.href)
      twttr.widgets.load(element.parentNode)


Template.index.events
#  "click .selector": (event, template) ->

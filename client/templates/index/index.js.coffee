Template.index.helpers
#  helper: ->

Template.index.rendered = ->
  if typeof window.gapi isnt "undefined" # loaded
    $(".g-plusone").each (index, element) ->
      gapi.plusone.render(element, $(element).data())
  if typeof window.FB isnt "undefined" # loaded
    $(".fb-button").each (index, element) ->
      FB.XFBML.parse(element.parentNode)

Template.index.events
#  "click .selector": (event, template) ->

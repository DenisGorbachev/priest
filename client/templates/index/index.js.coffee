Template.index.helpers
#  helper: ->

Template.index.rendered = ->
  $(".g-plusone").each (index, element) ->
    gapi.plusone.render(element, $(element).data())

Template.index.events
#  "click .selector": (event, template) ->

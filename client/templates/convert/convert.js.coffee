Template.convert.helpers
#  helper: ->

Template.convert.rendered = ->
  if isDebug
    loadSample(@)

Template.convert.events
  "click .load-sample": encapsulate (event, template) ->
    loadSample(template)

loadSample = (template) ->
  $(template.find(".input textarea")).val(template.data.tool.converter().getSample())
Template.css2stylus.helpers
#  helper: ->

Template.css2stylus.rendered = ->
  if isDebug
    _.defer =>
      share.converter.loadSample(@)
      share.converter.convert(@)

Template.css2stylus.events
  "keyup .input textarea": encapsulate (event, template) ->
    share.converter.convert(template)
  "paste .input textarea": encapsulate (event, template) ->
    _.defer ->
      share.converter.convert(template)
      share.converter.select(template)
  "change .options input[type='checkbox']": encapsulate (event, template) ->
    share.converter.convert(template)
    share.converter.select(template)
  "click .load-sample": encapsulate (event, template) ->
    share.converter.loadSample(template)
    share.converter.convert(template)
    share.converter.select(template)


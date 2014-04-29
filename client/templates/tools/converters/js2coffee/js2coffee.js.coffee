Template.js2coffee.helpers
#  helper: ->

Template.js2coffee.rendered = ->
  template = @
  if isDebug
    _.defer ->
      share.converter.loadSample(template)
      share.converter.convert(template)
  share.converter.selectInput(template)

Template.js2coffee.events
  "keyup .input textarea": encapsulate (event, template) ->
    share.converter.convert(template)
  "paste .input textarea": encapsulate (event, template) ->
    _.defer ->
      share.converter.convert(template)
      share.converter.selectOutput(template)
  "change .options input[type='checkbox']": encapsulate (event, template) ->
    share.converter.convert(template)
    share.converter.selectOutput(template)
  "click .load-sample": encapsulate (event, template) ->
    share.converter.loadSample(template)
    share.converter.convert(template)
    share.converter.selectOutput(template)


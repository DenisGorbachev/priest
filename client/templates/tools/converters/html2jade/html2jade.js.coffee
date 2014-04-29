Template.html2jade.helpers
#  helper: ->

Template.html2jade.rendered = ->
  template = @
  if isDebug
    _.defer ->
      share.converter.loadSample(template)
      share.converter.convert(template)
  share.converter.selectInput(template)

Template.html2jade.events
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


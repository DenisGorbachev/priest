Template.html2jade.helpers
#  helper: ->

Template.html2jade.rendered = ->
  if isDebug
    $(".input iframe").show()
    _.defer =>
      share.converter.loadSample(@)
      share.converter.convert(@)

Template.html2jade.events
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


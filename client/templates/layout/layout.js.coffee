Template.layout.helpers
  categoryTools: (isActive) ->
    _.filter(share.tools, (tool) => tool.categorySlug is @slug and tool.isActive is isActive)
  toolUrl: ->
    "/" + @categorySlug + "/" + @slug

Template.layout.rendered = ->

Template.layout.events
#  "click .selector": (event, template) ->

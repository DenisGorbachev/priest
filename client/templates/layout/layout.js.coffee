Template.layout.helpers
  categories: ->
    share.Categories.find()
  categoryTools: (isActive) ->
    share.Tools.find({categoryId: @_id, isActive: isActive})
  toolUrl: ->
    "/" + @category().slug + "/" + @slug

Template.layout.rendered = ->

Template.layout.events
#  "click .selector": (event, template) ->

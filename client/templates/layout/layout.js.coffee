Template.layout.helpers
  categories: ->
    share.Categories.find()
  categoryTools: (isActive) ->
    share.Tools.find({categoryId: @_id, isActive: isActive})
  toolUrl: ->
    "/" + @category().slug + "/" + @slug

Template.layout.rendered = ->

Template.layout.events
  "submit .subscribe": grab encapsulate (event, template) ->
    $form = $(event.currentTarget)
    data = {}
    for field in $form.serializeArray()
      data[field.name] = field.value
    check(data,
      email: String
      interest: String
    )
    mixpanel.identify(data.email)
    mixpanel.people.set(
      name: data.email
    )
    mixpanel.people.append("interests", data.interest)
    $form.hide()
    $form.parent().find(".thank-you").show()
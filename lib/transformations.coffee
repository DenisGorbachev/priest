class share.User
  constructor: (doc) ->
    _.extend(@, doc)
    @email = @emails?[0]?.address
    @name = @profile.name
    @firstName = @name.split(' ').slice(0, 1).join(' ')
    @lastName = @name.split(' ').slice(1).join(' ')

class share.Category
  constructor: (doc) ->
    _.extend(@, doc)

class share.Tool
  constructor: (doc) ->
    _.extend(@, doc)
  category: ->
    share.Categories.findOne({_id: @categoryId})

share.Transformations =
  User: (user) ->
    if user instanceof share.User or not user then user else new share.User(user)
  Category: (category) ->
    if category instanceof share.Category or not category then category else new share.Category(category)
  Tool: (tool) ->
    if tool instanceof share.Tool or not tool then tool else new share.Tool(tool)

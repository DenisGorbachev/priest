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

class share.Converter extends share.Tool
  converter: ->
    @_converter or @_converter = new share[@from + "To" + @to + "Converter"]


share.Transformations =
  user: (user) ->
    if user instanceof share.User or not user then user else new share.User(user)
  category: (category) ->
    if category instanceof share.Category or not category then category else new share.Category(category)
  tool: (tool) ->
    if tool.type
      return share.Transformations[tool.type](tool)
    if tool instanceof share.Tool or not tool then tool else new share.Tool(tool)
  converter: (converter) ->
    if converter instanceof share.Converter or not converter then converter else new share.Converter(converter)



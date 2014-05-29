class share.StylusToCSSConverter
  convert: (value, formOptions = []) ->
    result = undefined
    stylus(value).render (err, value) ->
      result = value
    result
  name: ->
    return "StylusToCSSConverter"


class share.StylusToCSSConverter
  convert: (value, formOptions = []) ->
    cl "value = " + value
    result = undefined
    stylus(value).render (err, value) ->
      result = value
    result


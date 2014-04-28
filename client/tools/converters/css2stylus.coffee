class share.CSSToStylusConverter extends share.CSSConverter
  executor: ->
    @_executor or @_executor = new Css2Stylus.Converter()
  convert: (value) ->
    executor = new Css2Stylus.Converter(value)
#    executor.css = value
    executor.processCss()
    executor.getStylus()
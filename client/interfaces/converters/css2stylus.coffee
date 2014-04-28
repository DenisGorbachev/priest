class share.CSSToStylusConverter extends share.CSSConverter
  executor: ->
    @_executor or @_executor = new Css2Stylus.Converter()
  convert: (value, formOptions) ->
    executor = new Css2Stylus.Converter(value)
    options =
      cssSyntax: false
      unPrefix: true
    for option in formOptions
      if option.name is "cssSyntax"
        options.cssSyntax = true
      if option.name is "doPrefix"
        options.unPrefix = false
#    executor.css = value
    executor.processCss(options)
    executor.getStylus()
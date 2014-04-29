class share.HTMLToJadeConverter
  getSample: ->
    sample = """
    <!doctype html>
    <html>
        <head>
          <link type="text/css" rel="stylesheet" href="/site.css" />
          <title>Hello</title>
        </head>
        <body>
          <h1>Hello world!</h1>
        </body>
    </html>
    """
    sample.trim()
  convert: (value, formOptions = []) ->
    share.html2jadeConvert(value)
#    options =
#      cssSyntax: false
#      unPrefix: true
#    for option in formOptions
#      if option.name is "cssSyntax"
#        options.cssSyntax = true
#      if option.name is "doPrefix"
#        options.unPrefix = false
#
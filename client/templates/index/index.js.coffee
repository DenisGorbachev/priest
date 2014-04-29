Template.index.helpers
  isWebkit: ->
    jQuery.browser.webkit
  errors: ->
    Session.get("futurizator-errors")

Template.index.rendered = ->

Template.index.events
  "change .files": encapsulate (event, template) ->
    errors = []
    Session.set("futurizator-errors", errors)
    zip = new JSZip()
    input = event.currentTarget
    save = _.after(input.files.length, ->
      count = zip.file(/.*/).length + zip.folder(/.*/).length
      if not count
        errors.push("No files selected")
      Session.set("futurizator-errors", errors)
      $(input).replaceWith($(input).clone(true))
      if count is 1
        file = zip.file(/.*/)[0]
        saveAs new Blob([file.asArrayBuffer()]), file.name
      else if count
        content = zip.generate(type: "blob")
        saveAs content, "converted.zip"
    )
    JavaScriptToCoffeeScriptConverter = new share.JavaScriptToCoffeeScriptConverter()
    CSSToStylusConverter = new share.CSSToStylusConverter()
    HTMLToJadeConverter = new share.HTMLToJadeConverter()
    for file in event.currentTarget.files
      reader = new FileReader()
      reader.onload = _.partial((file, e) ->
        result = e.target.result
        path = file.webkitRelativePath or file.name
        try
          switch true
            when !!path.match(/\.js$/i)
              result = JavaScriptToCoffeeScriptConverter.convert(ab2str(result))
              path = path.replace(/\.js$/i, ".coffee")
            when !!path.match(/\.css$/i)
              result = CSSToStylusConverter.convert(ab2str(result))
              path = path.replace(/\.css$/i, ".styl")
            when !!path.match(/\.html$/i)
              result = HTMLToJadeConverter.convert(ab2str(result))
              path = path.replace(/\.html$/i, ".jade")
            else
            # noop
        catch e
          errors.push(path + " :: " + e.toString())
        zip.file(path, result)
      , file)
      reader.onloadend = ->
        save()
      reader.readAsArrayBuffer(file)
  "dragover .drop-area": grab encapsulate (event, template) ->
  "drop .drop-area": grab encapsulate (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    for f in event.originalEvent.dataTransfer.files
      cl f

ab2str = (buf) ->
  String.fromCharCode.apply null, new Uint8Array(buf)

str2ab = (str) ->
  buf = new ArrayBuffer(str.length * 2) # 2 bytes for each char
  bufView = new Uint16Array(buf)
  i = 0
  strLen = str.length

  while i < strLen
    bufView[i] = str.charCodeAt(i)
    i++
  buf

Session.setDefault("futurizator-errors", [])

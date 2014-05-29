Template.index.helpers
  isWebkit: ->
    jQuery.browser.webkit
  errors: ->
    Session.get("index-errors")
  spaceIndentation: ->
    ReactiveStore.get(indentationCharacter) is space
  tabIndentation: ->
    ReactiveStore.get(indentationCharacter) is tab
  spaceIndentationCount: ->
    ReactiveStore.get(spaceIndentationCount)
  tabIndentationCount: ->
    ReactiveStore.get(tabIndentationCount)
  result: ->
    newConverter.convert()
  hide: ->
    Session.equals("hide", "")
  placeholder: ->
    Session.get("placeholder")

Template.index.rendered = ->
  template = @
  #  if isDebug
  #    _.defer ->
  #      share.converter.loadSample(template)
  #      converter.convert(template)
  #      share.converter.showOutput(template)
  newConverter.setInput(template)

Template.index.events
  "change .files": encapsulate (event, template) ->
    errors = []
    Session.set("index-errors", errors)
    zip = new JSZip()
    input = event.currentTarget
    save = _.after(input.files.length, ->
      count = zip.file(/.*/).length + zip.folder(/.*/).length
      if not count
        errors.push("No files selected")
      Session.set("index-errors", errors)
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
          condition = true
          switch condition
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
  "paste .input textarea": encapsulate (event, template) ->
    _.defer ->
      newConverter.setInput(template)
      newConverter.selectOutput(template)
      Session.set("placeholder", "placeholder-textarea-solid")
  "paste .input textarea": encapsulate (event, template) ->
    _.defer ->
      newConverter.setInput(template)
      newConverter.selectOutput(template)
      Session.set("placeholder", "placeholder-textarea-solid")
  "keydown .input textarea": encapsulate (template) ->
    Session.set("placeholder", "placeholder-textarea-solid")
  "keyup .input textarea": encapsulate (event, template) ->
    newConverter.setInput(template)
  "change .indentation-character": encapsulate (event, template) ->
    setSessionVariables($(event.currentTarget).closest(".indentation-wrapper"))
    newConverter.selectOutput(template)
  "focus .indentation-count": encapsulate (event) ->
    setSessionVariables($(event.currentTarget).closest(".indentation-wrapper"))
  "keyup .indentation-count": encapsulate (event, template) ->
    ReactiveStore.set(ReactiveStore.get(indentationCharacter) + "IndentationCount",  $(event.currentTarget).val())
  "input .indentation-count": encapsulate (event, template) ->
    value = $(event.currentTarget).val()
    if value
      ReactiveStore.set(ReactiveStore.get(indentationCharacter) + "IndentationCount",value)
      newConverter.selectOutput(template)

setSessionVariables = ($indentationWrapper) ->
  ReactiveStore.set(indentationCharacter, $indentationWrapper.find(".indentation-character").val())
  ReactiveStore.set(ReactiveStore.get(indentationCharacter) + "IndentationCount", $indentationWrapper.find(".indentation-count").val())

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

Session.setDefault("index-errors", [])

newConverter = _.defaults(
  convert: () ->
    output = ""
    input = Session.get("input")
    if input
      for toolConverter in [
                            new share.JavaScriptToCoffeeScriptConverter(),
                            new share.HTMLToJadeConverter(),
                            new share.JadeToHtmlConverter(),
                            new share.CSSToStylusConverter(),
                            new share.CoffeeScriptToJavaScriptConverter()
                            ]
        try
          output = toolConverter.convert(input)
        catch e
          continue
        if not output
          continue
        break

    count = ReactiveStore.get(ReactiveStore.get(indentationCharacter) + "IndentationCount")

    if ReactiveStore.get(indentationCharacter) is space
      whatToChange = " "
    else
      whatToChange = "\t"

    outputLines = output.split("\n");
    output = ""
    for line in outputLines
      beggining = line.match(/^\s+/)
      if beggining
        begginingMatch = beggining[0].match(/\s\s/g)
        if begginingMatch
          output += _.str.repeat(whatToChange, begginingMatch.length * count)
      output += line.trim()
      output += "\n"

    Session.set("hide", output.trim())
    output.trim()

  setInput: (template) ->
    input = $(template.find(".input textarea")).val()
    inputValue = input.trim()
    Session.set("input", inputValue)

    cl "input = [" + input + "]"
    cl input != ""
    if input
      Session.set("placeholder", "placeholder-textarea-solid")
    else
      Session.set("placeholder", "")

  selectOutput: (template) ->
    _.defer ->
      $(template.find(".output textarea")).select()

)

indentationCharacter = "indentationCharacter"
spaceIndentationCount = "spaceIndentationCount"
tabIndentationCount = "tabIndentationCount"
space = "space"
tab = "tab"

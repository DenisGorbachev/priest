Template.index.helpers
  isWebkit: ->
    jQuery.browser.webkit
  errors: ->
    Session.get("index-errors")

Template.index.rendered = ->
  template = @
  #  if isDebug
  #    _.defer ->
  #      share.converter.loadSample(template)
  #      converter.convert(template)
  #      share.converter.showOutput(template)
  share.converter.selectInput(template)

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
  "keyup .input textarea": encapsulate (event, template) ->
    output = converter.convert(template)
    if output
      share.converter.showOutput(template)
  "paste .input textarea": encapsulate (event, template) ->
    _.defer ->
      output = converter.convert(template)
      if output
        share.converter.showOutput(template)
        share.converter.selectOutput(template)
  "change .options input[type='checkbox']": encapsulate (event, template) ->
    output = converter.convert(template)
    if output
      share.converter.showOutput(template)
      share.converter.selectOutput(template)
  "click .load-sample": encapsulate (event, template) ->
    share.converter.loadSample(template)
    output = converter.convert(template)
    if output
      share.converter.showOutput(template)
      share.converter.selectOutput(template)
  "change input.tabRadioButton": encapsulate (event, template) ->
    output = converter.convert(template)
    if output
      share.converter.showOutput(template)
  "change input.spaceRadioButton": encapsulate (event, template) ->
    output = converter.convert(template)
    if output
      share.converter.showOutput(template)
  "change input.spaceTextField": encapsulate (event, template) ->
    output = converter.convert(template)
    if output
      share.converter.showOutput(template)
  "change input.tabTextField": encapsulate (event, template) ->
    output = converter.convert(template)
    if output
      share.converter.showOutput(template)
  "click input.tabTextField": encapsulate (event, template)->
    $(template.find("input.spaceRadioButton")).prop("checked", false)
    $(template.find("input.tabRadioButton")).prop("checked", true)
    output = converter.convert(template)
    if output
      share.converter.showOutput(template)
  "click input.spaceTextField": encapsulate (event, template)->
    $(template.find("input.spaceRadioButton")).prop("checked", true)
    $(template.find("input.tabRadioButton")).prop("checked", false)
    output = converter.convert(template)
    if output
      share.converter.showOutput(template)


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

converter = _.defaults(
  convert: (template) ->
    $input = $(template.find(".input textarea"))
    $output = $(template.find(".output textarea"))
    $options = $(template.find(".options"))
    input = $input.val().trim()
    output = ""
    options = if $options.length then $options.serializeArray() else []
    if input
      for toolConverter in [new share.JavaScriptToCoffeeScriptConverter(), new share.CSSToStylusConverter(), new share.HTMLToJadeConverter()]
        try
          output = toolConverter.convert(input, options)
        catch e
          continue
        if not output
          continue
        break
    spaces = $(template.find("input.spaceRadioButton")).prop("checked")
    count = 0
    if spaces
      $count = $(template.find("input.spaceTextField"))
      whatToChange = " "
      count = $count.val()
    else
      $count = $(template.find("input.tabTextField"))
      whatToChange = "\t"
      count = $count.val()

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

    $output.val(output)
    output
)
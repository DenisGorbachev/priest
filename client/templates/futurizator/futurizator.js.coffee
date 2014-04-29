Template.futurizator.helpers
#  helper: ->

Template.futurizator.rendered = ->

Template.futurizator.events
  "change .files": encapsulate (event, template) ->
    zip = new JSZip()
    save = _.after(event.currentTarget.files.length, ->
      content = zip.generate(type: "blob")
      saveAs content, "example.zip"
    )
    cl event.currentTarget.files.length
    for file in event.currentTarget.files
      cl "---"
      if not file.type # directory
        save()
        continue
      cl file
      reader = new FileReader()
      reader.onload = _.partial((file, e) ->
        zip.file(file.name, e.target.result)
        save()
      , file)
      blob =  reader.readAsArrayBuffer(file)
  "dragover .drop-area": grab encapsulate (event, template) ->
  "drop .drop-area": grab encapsulate (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    for f in event.originalEvent.dataTransfer.files
      cl f
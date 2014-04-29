share.converter =
  convert: (template) ->
    $input = $(template.find(".input textarea"))
    $output = $(template.find(".output textarea"))
    $options = $(template.find(".options"))
    if $options.length
      options = $options.serializeArray()
    else
      options = []
    value = template.data.tool.converter().convert($input.val(), options)
    $output.val(value)
  loadSample: (template) ->
    $(template.find(".input textarea")).val(template.data.tool.converter().getSample())
  selectInput: (template) ->
    _.defer ->
      $(template.find(".input textarea")).select()
  selectOutput: (template) ->
    _.defer ->
      $(template.find(".output textarea")).select()
share.converter =
  convert: (template) ->
    $input = $(template.find(".input textarea"))
    $output = $(template.find(".output textarea"))
    value = template.data.tool.converter().convert($input.val())
    $output.val(value)
  loadSample: (template) ->
    $(template.find(".input textarea")).val(template.data.tool.converter().getSample())
  select: (template) ->
    _.defer ->
      $(template.find(".output textarea")).select()

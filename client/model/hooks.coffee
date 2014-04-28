share.Tools.before.insert (userId, tool) ->
  if tool.type is "converter"
    _.defaults(tool,
      name: tool.from + " to " + tool.to
      slug: tool.from.toLowerCase() + "-to-" + tool.to.toLowerCase()
    )
Router.configure
  layoutTemplate: "layout"
  notFoundTemplate: "notFound"
  loadingTemplate: "loading"

Router.map ->
  @route "index",
    path: "/"
    onAfterAction: ->
      share.setPageTitle("Quux, free online tools for programmers", false)
  @route "convert",
    path: "/convert"
  @route "convertWithTool",
    path: "/convert/:slug"
    template: "convert"
    data: ->
      {
        tool: share.Tools.findOne({slug: @params.slug})
      }
    action: ->
      @render(@data().tool.template)
  @route "validate",
    path: "/validate"
  @route "security",
    path: "/encrypt-and-decrypt"
  @route "beautify",
    path: "/beautify"

share.setPageTitle = (title, appendSiteName = true) ->
  if appendSiteName
    title += " - Priest"
  if Meteor.settings.public.isDebug
    title = "(D) " + title
  document.title = title

Router.onAfterAction ->
  share.debouncedSendPageview()

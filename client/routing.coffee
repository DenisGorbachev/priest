Router.configure
  layoutTemplate: "layout"
  notFoundTemplate: "notFound"
  loadingTemplate: "loading"

Router.map ->
  @route "index",
    path: "/"
    onAfterAction: ->
      share.setPageTitle("Priest, free online converter and formatter", false)
  @route "convert",
    path: "/convert/:slug"
    template: "convert"
    data: ->
      {
        tool: share.Tools.findOne({slug: @params.slug})
      }
    action: ->
      @render(@data().tool.template)
  @route "futurizator",
    path: "/futurizator-batch-convert"

share.setPageTitle = (title, appendSiteName = true) ->
  if appendSiteName
    title += " - Priest"
  if Meteor.settings.public.isDebug
    title = "(D) " + title
  document.title = title

Router.onAfterAction ->
  share.debouncedSendPageview()

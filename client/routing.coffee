Router.configure
  layoutTemplate: "layout"
  notFoundTemplate: "notFound"
  loadingTemplate: "loading"

Router.map ->
  @route "index",
    path: "/"
  @route "tool",
    path: "/:category:/:slug"
    action: ->
      @render(@params.slug)
CRUD = window.CRUD = new Marionette.Application()

CRUD.Configuration =
  root: ""
  version: "v1"
  loggingEnabled: true

CRUD.addRegions
  headerRegion: "#header-region"
  mainRegion: "#main-region"

CRUD.navigate = (route, options={}) ->
  root = CRUD.Configuration.root
  route = route.replace root, "" if _.startsWith route, root
  Backbone.history.navigate route, options

CRUD.getCurrentRoute = ->
  Backbone.history.fragment

CRUD.linkTo = (relative = "") ->
  root = CRUD.Configuration.root
  "#{root}/#{relative}"

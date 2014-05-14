"use strict"
_        = require "underscore"
Backbone = require "backbone"

CRUD = new Backbone.Marionette.Application()

CRUD.Configuration =
  root: ""
  version: "v1"
  loggingEnabled: true

CRUD.navigate = (route, options={}) ->
  root = CRUD.Configuration.root
  route = route.replace root, "" if _.str.startsWith route, root
  Backbone.history.navigate route, options

CRUD.getCurrentRoute = ->
  Backbone.history.fragment

CRUD.linkTo = (relative = "") ->
  root = CRUD.Configuration.root
  "#{root}/#{relative}"

CRUD.addRegions
  headerRegion: "#header-region"
  mainRegion: "#main-region"

module.exports = CRUD

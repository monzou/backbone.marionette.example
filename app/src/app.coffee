"use strict"
_        = require "underscore"
Backbone = require "backbone"

class CRUD extends Backbone.Marionette.Application

  root: ""
  version: "v2"

  constructor: ->
    super
    @setupRegions()
    @setupXhr()

  setupRegions: ->
    @addRegions
      headerRegion: "#header-region"
      mainRegion: "#main-region"

  setupXhr: ->
    $.ajaxSettings.timeout = 5000
    $.ajaxSettings.cache = false

  navigate: (route, options={}) ->
    route = route.replace @root, "" if _.str.startsWith route, @root
    Backbone.history.navigate route, options

  getCurrentRoute: ->
    Backbone.history.fragment

module.exports = new CRUD

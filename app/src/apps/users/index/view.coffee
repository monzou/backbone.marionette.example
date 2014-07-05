"use strict"
Backbone = require "backbone"

module.exports = class View extends Backbone.Marionette.LayoutView

  template: "#users-index"
  regions:
    headerRegion: "#users-index-header-region"
    listRegion: "#users-index-list-region"

  constructor: (options) ->
    super options
    @headerView = options.headerView
    @listView = options.listView

  onRender: ->
    @headerRegion.show @headerView
    @listRegion.show @listView
"use strict"
Backbone        = require "backbone"
CRUD            = require "app/app"
HeaderViewModel = require "app/apps/header/view_model"
HeaderView      = require "app/apps/header/view"

module.exports = class HeaderController extends Backbone.Marionette.Controller

  constructor: (@region) ->
    @model = new HeaderViewModel

  update: (menu) ->
    @model.set "menu", menu

  show: ->
    view = new HeaderView model: @model
    @region.show view

  hide: ->
    @region.destroy()

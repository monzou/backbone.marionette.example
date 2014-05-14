"use strict"
Backbone = require "backbone"
CRUD     = require "app/app"

module.exports = class HeaderView extends Backbone.Marionette.ItemView

  template: "#users-index-header"
  behaviors:
    binding: {}
  bindings:
    "#query": "query"
    ".btn-new":
      attributes: [
        name: "href"
        onGet: -> CRUD.request "route:users:new"
      ]

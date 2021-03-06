"use strict"
Backbone = require "backbone"
CRUD     = require "app/app"

module.exports = class HeaderView extends Backbone.Marionette.ItemView

  template: "#header"

  behaviors:
    stickit:
      bindings:
        ".navbar-brand":
          attributes: [
            name: "href"
            onGet: -> CRUD.request "route:users:list"
          ]

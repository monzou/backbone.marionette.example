"use strict"
CRUD             = require "app/app"
HeaderController = require "app/apps/header/controller"

CRUD.addInitializer ->
  controller = new HeaderController CRUD.headerRegion
  CRUD.on "initialize:after", -> controller.show()
  
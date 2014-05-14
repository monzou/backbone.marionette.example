"use strict"
CRUD            = require "app/app"
ResourceRouter  = require "app/common/resource_router"
IndexController = require "app/apps/users/index/controller"
NewController   = require "app/apps/users/new/controller"
EditController  = require "app/apps/users/edit/controller"

class UsersRouter extends ResourceRouter

  resource: "users"
  appRoutes:
    "": "list"
    "new": "new"
    ":id": "edit"

API =

  list: ->
    controller = new IndexController CRUD.mainRegion
    controller.show()
    CRUD.trigger "set:menu:active", "users:index"

  new: ->
    controller = new NewController CRUD.mainRegion
    controller.show()
    CRUD.trigger "set:menu:active", "users:new"

  edit: (id) ->
    controller = new EditController CRUD.mainRegion
    controller.show id
    CRUD.trigger "set:menu:active", "users:edit"

CRUD.addInitializer -> new UsersRouter controller: API

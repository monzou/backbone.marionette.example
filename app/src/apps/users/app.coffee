Users  = CRUD.module "Users"
Common = CRUD.module "Common"

class Users.Router extends Common.ResourceRouter

  resource: "users"
  appRoutes:
    "": "list"
    "new": "new"
    ":id": "edit"

API = Users.API =

  list: ->
    controller = new Users.Index.Controller CRUD.mainRegion
    controller.show()
    CRUD.trigger "set:menu:active", "users:index"

  new: ->
    controller = new Users.New.Controller CRUD.mainRegion
    controller.show()
    CRUD.trigger "set:menu:active", "users:new"

  edit: (id) ->
    controller = new Users.Edit.Controller CRUD.mainRegion
    controller.show id
    CRUD.trigger "set:menu:active", "users:edit"

CRUD.addInitializer -> new Users.Router controller: API

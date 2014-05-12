Header = CRUD.module "Header"

class Header.Controller extends Marionette.Controller

  constructor: (@region) ->
    @model = new Header.ViewModel
    @listenTo CRUD, "set:menu:active", (menu) => @update menu

  update: (menu) ->
    @model.set "menu", menu

  show: ->
    view = new Header.View model: @model
    @region.show view

  hide: ->
    @region.close()

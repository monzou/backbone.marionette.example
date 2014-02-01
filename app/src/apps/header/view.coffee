Header = CRUD.module "Header"

class Header.View extends Marionette.ItemView

  template: "#header"

  bindings:
    ".activeMenu": "menu"
    ".navbar-brand":
      attributes: [
        name: "href"
        onGet: -> CRUD.request "route:users:list"
      ]

  onRender: ->
    @stickit()

  onClose: ->
    @unstickit()

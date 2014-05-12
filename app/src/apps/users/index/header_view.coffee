Search = CRUD.module "Users.Search"
Index  = CRUD.module "Users.Index"

class Index.HeaderView extends Marionette.ItemView

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

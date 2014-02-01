Index = CRUD.module "Users.Index"

class Index.SearchFormView extends Marionette.ItemView

  template: "#users-search-form"
  bindings:
    "#name": "name"
    "#email": "email"

  onRender: ->
    @stickit()

  onClose: ->
    @unstickit()

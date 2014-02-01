Index = CRUD.module "Users.Index"

class Index.UserRowView extends Marionette.ItemView

  tagName: "tr"
  template: "#user-row"
  bindings:
    "input[type=checkbox]": "selected"
    ".fullName":
      observe: "fullName"
      attributes: [
        name: "href"
        onGet: -> CRUD.request "route:users:edit", @model.get "id"
      ]
    ".email": "email"

  onRender: ->
    @stickit()

  onClose: ->
    @unstickit()

class Index.UserListView extends Marionette.CompositeView

  itemView: Index.UserRowView
  itemViewContainer: "tbody"
  template: "#users-index-list"
  triggers:
    "click .delete-button": "users:selected:delete"
  bindings:
    ".selected-info":
      observe: "selectedUsers"
      visible: (value) -> value and value.length > 0
    ".selected-users":
      observe: "selectedUsers"
      onGet: (value) -> if value then value.length else 0
    ".delete-button":
      attributes: [
        observe: "selectedUsers"
        name: "disabled"
        onGet: (value) -> if value and value.length > 0 then "" else "disabled"
      ]

  onRender: ->
    @stickit()

  onClose: ->
    @unstickit()
    
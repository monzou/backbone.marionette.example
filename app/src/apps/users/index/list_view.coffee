"use strict"
Backbone = require "backbone"
CRUD     = require "app/app"

class UserRowView extends Backbone.Marionette.ItemView

  tagName: "tr"
  template: "#user-row"
  behaviors:
    stickit:
      attr: "class"
      bindings:
        "input[type=checkbox]": "selected"
        ".fullName":
          observe: "fullName"
          attributes: [
            name: "href"
            onGet: -> CRUD.request "route:users:edit", @model.get "id"
          ]

module.exports = class UserListView extends Backbone.Marionette.CompositeView

  childView: UserRowView
  childViewContainer: "tbody"
  template: "#users-index-list"
  triggers:
    "click .delete-button": "users:selected:delete"
  behaviors:
    stickit:
      bindings:
        ".selected-info":
          observe: "selectedUsers"
          visible: (value) -> value and value.length > 0
        ".selected-users-count":
          observe: "selectedUsers"
          onGet: (value) -> if value then value.length else 0
        ".delete-button":
          attributes: [
            observe: "selectedUsers"
            name: "disabled"
            onGet: (value) -> if value and value.length > 0 then "" else "disabled"
          ]

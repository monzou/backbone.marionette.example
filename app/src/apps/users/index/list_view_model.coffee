"use strict"
ViewModel          = require "app/common/view_model"
UserViewModel      = require "app/apps/users/common/model/user"
UserViewCollection = require "app/apps/users/common/model/users"

module.exports = class UserListViewModel extends ViewModel

  view:
    selectedUsers:
      observe: [ "selected" ]
      value: -> @get("collection").where "selected": true

  constructor: (attributes={}, options) ->
    collection = attributes.collection = new UserViewCollection
    @listenTo collection, "change:selected", => @trigger "change:selected"
    super attributes, options

  updateCollection: (models) ->
    collection = @get "collection"
    collection.reset _.map models, (model) -> new UserViewModel {}, model: model
    collection.clearSelection()
    collection

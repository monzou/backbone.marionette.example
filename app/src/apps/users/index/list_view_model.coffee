Common = CRUD.module "Users.Common"
Index  = CRUD.module "Users.Index"

class Index.UserListViewModel extends CRUD.Common.ViewModel

  view:
    selectedUsers:
      observe: [ "selected" ]
      value: -> @get("collection").where "selected": true

  constructor: (attributes={}, options) ->
    collection = attributes.collection = new Common.UserViewCollection
    collection.on "change:selected", => @trigger "change:selected"
    super attributes, options

  updateCollection: (models) ->
    collection = @get("collection")
    collection.reset _.map models, (model) -> new Common.UserViewModel {}, model: model
    collection.clearSelection()
    collection

Common = CRUD.module "Users.Common"

class Common.UserViewModel extends CRUD.Common.ViewModel

  view:
    fullName:
      observe: [ "firstName", "lastName" ]
      value: -> (_.filter [ @get("firstName"), @get("lastName") ], (name) -> not _.isBlank name).join (" ")

class Common.UserViewCollection extends Backbone.Collection

  model: Common.UserViewModel

  clearSelection: ->
    _.each @models, (model) -> model.set "selected", false

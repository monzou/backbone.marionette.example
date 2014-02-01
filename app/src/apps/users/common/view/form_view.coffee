Common = CRUD.module "Users.Common"

class Common.FormViewModel extends Common.UserViewModel

  view: _.extend @::view,
    title:
      observe: [ "fullName" ]
      value: ->
        title = "#{@action} User"
        fullName = @get "fullName"
        title = "#{title} (#{fullName})" unless _.isBlank fullName
        title

class Common.FormView extends Marionette.ItemView

  # TODO Validation

  template: "#user-form"
  triggers:
    "click .save-button": "user:form:save"
    "click .cancel-button": "user:form:cancel"
  bindings:
    "#title": "title"
    "#firstName": "firstName"
    "#lastName": "lastName"
    "#email": "email"
    "#remarks": "remarks"

  onRender: ->
    @stickit()

  onClose: ->
    @unstickit()

  getEditingModel: ->
    @model.commit()

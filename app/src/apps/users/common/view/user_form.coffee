"use strict"
Backbone = require "backbone"

module.exports = class UserFormView extends Backbone.Marionette.ItemView

  # TODO Validation

  template: "#user-form"
  triggers:
    "click .save-button": "user:form:save"
    "click .cancel-button": "user:form:cancel"
  behaviors:
    binding: {}
  bindings:
    "#title": "title"
    "#firstName": "firstName"
    "#lastName": "lastName"
    "#email": "email"
    "#remarks": "remarks"

  getEditingModel: ->
    @model.commit()

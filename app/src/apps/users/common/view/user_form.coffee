"use strict"
Backbone = require "backbone"

module.exports = class UserFormView extends Backbone.Marionette.ItemView

  # TODO Validation

  template: "#user-form"
  triggers:
    "click .save-button": "user:form:save"
    "click .cancel-button": "user:form:cancel"
  behaviors:
    stickit: {}

  getEditingModel: ->
    @model.commit()

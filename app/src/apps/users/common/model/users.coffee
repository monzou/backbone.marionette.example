"use strict"
_             = require "underscore"
Backbone      = require "backbone"
UserViewModel = require "app/apps/users/common/model/user"

module.exports = class UserViewCollection extends Backbone.Collection

  model: UserViewModel

  clearSelection: ->
    _.each @models, (model) -> model.set "selected", false

"use strict"
_         = require "underscore"
ViewModel = require "app/common/view_model"

module.exports = class UserViewModel extends ViewModel

  view:
    fullName:
      observe: [ "firstName", "lastName" ]
      value: -> (_.filter [ @get("firstName"), @get("lastName") ], (name) -> not _.str.isBlank name).join (" ")

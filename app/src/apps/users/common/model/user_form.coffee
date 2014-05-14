"use strict"
_             = require "underscore"
UserViewModel = require "app/apps/users/common/model/user"

module.exports = class UserFormViewModel extends UserViewModel

  view: _.extend @::view,
    title:
      observe: [ "fullName" ]
      value: ->
        title = "#{@action} User"
        fullName = @get "fullName"
        title = "#{title} (#{fullName})" unless _.str.isBlank fullName
        title

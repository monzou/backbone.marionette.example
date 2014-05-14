"use strict"
Backbone   = require "backbone"
User       = require "app/model/user"

module.exports = class Users extends Backbone.Collection

  model: User
  

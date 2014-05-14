"use strict"
Repository = require "app/repository/base"
User       = require "app/model/user"
Users      = require "app/model/users"

class UserRepository extends Repository

  name: "users"
  model: User
  collection: Users

  query: (q) ->
    return @findAll() unless q
    @where (model) ->
      for name in [ "firstName", "lastName" ] 
        attr = model.get name
        return true if attr and _.str.contains(attr.toLowerCase(), q.trim().toLowerCase())
      false

UserRepository = new UserRepository
UserRepository.save new User firstName: "Shinji", lastName: "Okazaki"
UserRepository.save new User firstName: "Shinji", lastName: "Kagawa"
UserRepository.save new User firstName: "Keisuke", lastName: "Honda"

module.exports = UserRepository

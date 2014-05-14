"use strict"
Backbone       = require "backbone"
CRUD           = require "app/app"
User           = require "app/model/user"
UserRepository = require "app/repository/users"
ViewModel      = require "app/apps/users/new/view_model"
View           = require "app/apps/users/new/view"

module.exports = class Controller extends Backbone.Marionette.Controller

  constructor: (@region) ->
    _.bindAll @, "save", "goToIndex"

  show: ->
    view = @createView()
    @listenTo view, "user:form:save", @save
    @listenTo view, "user:form:cancel", @goToIndex
    @region.show view

  createView: ->
    model = new User
    viewModel = new ViewModel {}, model: model
    new View model: viewModel

  save: (params) ->
    model = params.model.commit()
    UserRepository.save(model).done @goToIndex

  goToIndex: ->
    CRUD.execute "action:users:list"

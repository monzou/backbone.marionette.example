"use strict"
Backbone       = require "backbone"
CRUD           = require "app/app"
User           = require "app/model/user"
UserRepository = require "app/repository/users"
ViewModel      = require "app/apps/users/edit/view_model"
View           = require "app/apps/users/edit/view"

module.exports = class EditController extends Backbone.Marionette.Controller

  constructor: (@region) ->
    _.bindAll @, "save", "goToIndex"

  show: (id) ->
    UserRepository.find(id).done (model) => @region.show @createView model

  createView: (model) ->
    viewModel = new ViewModel {}, model: model
    view = new View model: viewModel
    @listenTo view, "user:form:save", @save
    @listenTo view, "user:form:cancel", @goToIndex
    view

  save: (params) ->
    model = params.model.commit()
    UserRepository.save(model).done @goToIndex

  goToIndex: ->
    CRUD.execute "action:users:list"

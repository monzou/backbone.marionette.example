"use strict"
_                 = require "underscore"
Backbone          = require "backbone"
UserRepository    = require "app/repository/users"
HeaderViewModel   = require "app/apps/users/index/header_view_model"
UserListViewModel = require "app/apps/users/index/list_view_model"
HeaderView        = require "app/apps/users/index/header_view"
UserListView      = require "app/apps/users/index/list_view"
View              = require "app/apps/users/index/view"

module.exports = class Controller extends Backbone.Marionette.Controller

  constructor: (@region) ->
    _.bindAll @, "refreshUsers", "deleteSelectedUsers"
    @headerViewModel = new HeaderViewModel
    @listViewModel = new UserListViewModel
    @listenTo @headerViewModel, "change:query", _.throttle @refreshUsers, 200

  show: ->
    @region.show @createView()
    @refreshUsers()

  createView: (collection) ->
    headerView = @createHeaderView()
    listView = @createListView()
    new View headerView: headerView, listView: listView

  createHeaderView: ->
    new HeaderView model: @headerViewModel

  createListView: ->
    listView = new UserListView model: @listViewModel, collection: @listViewModel.get "collection"
    @listenTo listView, "users:selected:delete", @deleteSelectedUsers
    listView

  refreshUsers: ->
    searchCondition = @headerViewModel.commit()
    UserRepository.query(searchCondition.get "query").done (collection) => @listViewModel.updateCollection collection.models

  deleteSelectedUsers: ->
    selectedUsers = @listViewModel.get "selectedUsers"
    if selectedUsers and selectedUsers.length > 0
      _.each selectedUsers, (user) -> UserRepository.delete user.get("id")
      @refreshUsers()

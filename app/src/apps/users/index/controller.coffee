Model  = CRUD.module "Model"
Common = CRUD.module "Users.Common"
Index  = CRUD.module "Users.Index"

class Index.View extends Marionette.Layout

  template: "#users-index"
  regions:
    headerRegion: "#users-index-header-region"
    listRegion: "#users-index-list-region"

  constructor: (options) ->

    super options

    _.bindAll @, "refreshUsers", "deleteSelectedUsers"

    @searchFormViewModel = new Index.SearchFormViewModel
    @searchFormViewModel.on "change:name", _.debounce @refreshUsers, 200
    @headerView = new Index.HeaderView model: @searchFormViewModel

    @listViewModel = new Index.UserListViewModel
    @listView = new Index.UserListView model: @listViewModel, collection: @listViewModel.get "collection"
    @listView.on "delete:selectedUsers", @deleteSelectedUsers

  refreshUsers: ->
    searchCondition = @searchFormViewModel.commit()
    Model.UserRepository.query(searchCondition.get "name").done (collection) => @listViewModel.updateCollection collection.models

  deleteSelectedUsers: ->
    selectedUsers = @listViewModel.get "selectedUsers"
    if selectedUsers and selectedUsers.length > 0
      _.each selectedUsers, (user) -> Model.UserRepository.delete user.get("id")
      @refreshUsers()

  onShow: ->
    @headerRegion.show @headerView
    @listRegion.show @listView
    @refreshUsers()


class Index.Controller

  constructor: (@region) ->

  show: ->
    Model.UserRepository.findAll().done (collection) => @region.show @createView collection

  createView: (collection) ->
    new Index.View collection: collection

Model  = CRUD.module "Model"
Index  = CRUD.module "Users.Index"

class Index.View extends Marionette.Layout

  template: "#users-index"
  regions:
    headerRegion: "#users-index-header-region"
    listRegion: "#users-index-list-region"

  constructor: (options) ->
    super options
    @headerView = options.headerView
    @listView = options.listView

  onRender: ->
    @headerRegion.show @headerView
    @listRegion.show @listView

class Index.Controller extends Marionette.Controller

  constructor: (@region) ->
    _.bindAll @, "refreshUsers", "deleteSelectedUsers"
    @headerViewModel = new Index.HeaderViewModel
    @listViewModel = new Index.UserListViewModel
    @listenTo @headerViewModel, "change:query", _.throttle @refreshUsers, 200

  show: ->
    @region.show @createView()
    @refreshUsers()

  createView: (collection) ->
    headerView = @createHeaderView()
    listView = @createListView()
    new Index.View headerView: headerView, listView: listView

  createHeaderView: ->
    new Index.HeaderView model: @headerViewModel

  createListView: ->
    listView = new Index.UserListView model: @listViewModel, collection: @listViewModel.get "collection"
    @listenTo listView, "users:selected:delete", @deleteSelectedUsers
    listView

  refreshUsers: ->
    searchCondition = @headerViewModel.commit()
    Model.UserRepository.query(searchCondition.get "query").done (collection) => @listViewModel.updateCollection collection.models

  deleteSelectedUsers: ->
    selectedUsers = @listViewModel.get "selectedUsers"
    if selectedUsers and selectedUsers.length > 0
      _.each selectedUsers, (user) -> Model.UserRepository.delete user.get("id")
      @refreshUsers()

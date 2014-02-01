Model  = CRUD.module "Model"
Index  = CRUD.module "Users.Index"

class Index.View extends Marionette.Layout

  template: "#users-index"
  regions:
    headerRegion: "#users-index-header-region"
    listRegion: "#users-index-list-region"

  constructor: (options) ->

    super options

    _.bindAll @, "refreshUsers", "deleteSelectedUsers"

    @headerViewModel = new Index.HeaderViewModel
    @headerViewModel.on "change:query", _.debounce @refreshUsers, 200
    @headerView = new Index.HeaderView model: @headerViewModel

    @listViewModel = new Index.UserListViewModel
    @listView = new Index.UserListView model: @listViewModel, collection: @listViewModel.get "collection"
    @listView.on "users:selected:delete", @deleteSelectedUsers

  refreshUsers: ->
    searchCondition = @headerViewModel.commit()
    Model.UserRepository.query(searchCondition.get "query").done (collection) => @listViewModel.updateCollection collection.models

  deleteSelectedUsers: ->
    selectedUsers = @listViewModel.get "selectedUsers"
    if selectedUsers and selectedUsers.length > 0
      _.each selectedUsers, (user) -> Model.UserRepository.delete user.get("id")
      @refreshUsers()

  onShow: ->
    @headerRegion.show @headerView
    @listRegion.show @listView
    @refreshUsers()

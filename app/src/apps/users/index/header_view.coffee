Search = CRUD.module "Users.Search"
Index  = CRUD.module "Users.Index"

class Index.HeaderView extends Marionette.Layout

  template: "#users-index-header"
  regions:
    searchFormRegion: "#users-search-form-region"
  bindings:
    ".btn-new":
      attributes: [
        name: "href"
        onGet: -> CRUD.request "route:users:new"
      ]

  constructor: (options) ->
    super options
    @searchFormView = new Index.SearchFormView model: @model

  onShow: ->
    @searchFormRegion.show @searchFormView

  onRender: ->
    @stickit()

  onClose: ->
    @unstickit()

Model  = CRUD.module "Model"
Edit   = CRUD.module "Users.Edit"

class Edit.Controller extends Marionette.Controller

  constructor: (@region) ->
    _.bindAll @, "save", "goToIndex"

  show: (id) ->
    Model.UserRepository.find(id).done (model) => @region.show @createView model

  createView: (model) ->
    viewModel = new Edit.ViewModel {}, model: model
    view = new Edit.View model: viewModel
    @listenTo view, "user:form:save", @save
    @listenTo view, "user:form:cancel", @goToIndex
    view

  save: (params) ->
    model = params.model.commit()
    Model.UserRepository.save(model).done @goToIndex

  goToIndex: ->
    CRUD.execute "action:users:list"

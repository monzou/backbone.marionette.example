Model = CRUD.module "Model"
New   = CRUD.module "Users.New"

class New.Controller

  constructor: (@region) ->
    _.bindAll @, "save", "goToIndex"

  show: ->
    view = @createView()
    view.on "user:form:save", @save
    view.on "user:form:cancel", @goToIndex
    @region.show view

  createView: ->
    model = new Model.User
    viewModel = new New.ViewModel {}, model: model
    new New.View model: viewModel

  save: (params) ->
    model = params.model.commit()
    Model.UserRepository.save(model).done @goToIndex

  goToIndex: ->
    CRUD.execute "action:users:list"

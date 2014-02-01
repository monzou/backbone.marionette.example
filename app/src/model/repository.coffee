Model = CRUD.module "Model"

class Model.OnMemoryRepository

  constructor: (@models={}) ->

  save: (model) ->
    dfd = Backbone.$.Deferred()
    id = model.get "id"
    unless id
      id = (_.reduce @models, ((max, model) -> Math.max model.get("id"), max), 0) + 1
      model.set "id", id
    @models[id] = model
    @trigger "save", model
    dfd.resolve model

  trigger: (event, model) ->
    eventName = "#{@name}:#{event}"
    CRUD.trigger eventName, model
    CRUD.execute "log:debug", eventName, model

  find: (id) ->
    dfd = Backbone.$.Deferred()
    model = @models[id]
    if model
      dfd.resolve @clone model
    else
      dfd.reject()

  findAll: ->
    @where (model) -> true

  where: (filter) ->
    dfd = Backbone.$.Deferred()
    models = _.map (_.filter (_.values @models), filter), (model) => @clone model
    dfd.resolve new @collection models

  delete: (id) ->
    model = @models[id]
    if model
      delete @models[id]
      model

  clone: (model) ->
    new @model Backbone.$.extend(true, {}, model.toJSON())

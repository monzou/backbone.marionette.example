Model  = CRUD.module "Model"
Index  = CRUD.module "Users.Index"

class Index.Controller

  constructor: (@region) ->

  show: ->
    Model.UserRepository.findAll().done (collection) => @region.show @createView collection

  createView: (collection) ->
    new Index.View collection: collection

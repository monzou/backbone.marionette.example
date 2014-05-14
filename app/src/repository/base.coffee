"use strict"
_ = require "underscore"
$ = require "jquery"

module.exports = class OnMemoryRepository

  constructor: (@models={}) ->

  save: (model) ->
    dfd = $.Deferred()
    id = model.get "id"
    unless id
      id = (_.reduce @models, ((max, model) -> Math.max model.get("id"), max), 0) + 1
      model.set "id", id
    @models[id] = model
    dfd.resolve model

  find: (id) ->
    dfd = $.Deferred()
    model = @models[id]
    if model
      dfd.resolve @clone model
    else
      dfd.reject()

  findAll: ->
    @where (model) -> true

  where: (filter) ->
    dfd = $.Deferred()
    models = _.map (_.filter (_.values @models), filter), (model) => @clone model
    dfd.resolve new @collection models

  delete: (id) ->
    model = @models[id]
    if model
      delete @models[id]
      model

  clone: (model) ->
    new @model $.extend(true, {}, model.toJSON())

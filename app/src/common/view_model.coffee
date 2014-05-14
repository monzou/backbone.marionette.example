"use strict"
_        = require "underscore"
Backbone = require "backbone"

module.exports = class ViewModel extends Backbone.Model

  constructor: (attributes, options) ->
    super attributes, options
    @initializeViewModel options

  initializeViewModel: (options) ->
    @initializeModel options.model if options?.model
    @bindAttributeChangeHandlers()

  initializeModel: (model) ->
    @model = model
    @set Backbone.$.extend true, {}, @model.toJSON() if @model

  commit: ->
    return @ unless @model
    @model.set @getModelAttributes()
    @model

  getViewAttributes: ->
    _.pick @toJSON(), (_.keys @view)

  getModelAttributes: ->
    _.omit @toJSON(), (_.keys @view)    

  bindAttributeChangeHandlers: ->
    @handlers = {}
    _.each @view, (handler, key) =>
      value = undefined
      events = undefined
      if _.isString handler
        value = _.identity handler
      else if _.isFunction handler
        value = handler
      else if _.isObject handler
        events = (_.map handler.observe, (attr) -> "change:#{attr}").join(" ") if handler.observe
        value = _.bind (handler.value), @
      else
        throw "Unexpected handler: #{handler}"
      fn = => @set key, value.call @
      fn.call()
      @on events, fn, @ if events
      @handlers[key] = event: events, fn: fn
    @

  unbindAttributeChangeHandlers: ->
    for key, handler of @handlers
      @off handler.event, handler.fn if handler.event
      delete @handlers[key]
    @

  sync: ->
    throw "Unsupported operation"
    
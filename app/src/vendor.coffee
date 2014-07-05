"use strict"

###############################
# LOAD VENDOR MODULES
###############################

_  = require "underscore"
require "underscore.string"

Backbone   = require "backbone"
Backbone.$ = require "jquery"
require "backbone.marionette"
require "backbone.stickit"


###############################
# SETUP VENDOR MODULES
###############################

class StickitBindingBehavior extends Backbone.Marionette.Behavior

  createBindings: ($root, attr="name", ignores={}) ->
    bindings = Backbone.$.extend true, {}, @options.bindings
    $root.find("[#{attr}]").each ->
      $el = $(@)
      attribute = $el.attr attr
      return if bindings[attribute]
      for ignore in ignores
        if _.isString ignore
          return if ignore is attribute
        else if _.isObject ignore
          return if ignore.test and ignore.test attribute
      selector = "[#{attr}='#{attribute}']"
      tag = $el.prop("tagName").toLowerCase()
      key = "#{tag}#{selector}"
      return if bindings[key]
      bindings[key] = "observe": attribute
    bindings

  onRender: ->
    @view.bindings = @createBindings @$el, @options.attr, @options.ignores
    @view.stickit()

  onDestroy: ->
    @view.unstickit()

Backbone.Marionette.Behaviors.behaviorsLookup = ->
  stickit: StickitBindingBehavior

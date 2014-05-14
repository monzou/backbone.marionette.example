"use strict"

###############################
# LOAD VENDOR MODULES
###############################

require "underscore"
require "underscore.string"

Backbone   = require "backbone"
Backbone.$ = require "jquery"
require "backbone.marionette"
require "backbone.stickit"


###############################
# SETUP VENDOR MODULES
###############################

class StickitBindingBehavior extends Backbone.Marionette.Behavior

  onRender: ->
    @view.stickit @options?.optionalModel, @options?.optionalBindings

  onClose: ->
    @view.unstickit()

Backbone.Marionette.Behaviors.behaviorsLookup = ->
  binding: StickitBindingBehavior

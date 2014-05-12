_.mixin(_.str.exports())

class StickitBindingBehavior extends Backbone.Marionette.Behavior

  onRender: ->
    @view.stickit @options?.optionalModel, @options?.optionalBindings

  onClose: ->
    @view.unstickit()

Backbone.Marionette.Behaviors.behaviorsLookup = ->
  binding: StickitBindingBehavior

Common  = CRUD.module "Common"
exports = window

class CRUD.Logger

  constructor: (@level) ->
    @out = exports.console[@level] or= exports.console.log

  log: ->
    return unless CRUD.Configuration.loggingEnabled
    if @out.apply
      @out.apply exports.console, arguments # for Chrome
    else
      @out Array.prototype.join.call arguments, ","

CRUD.addInitializer ->
  _.each [
    "info"
    "debug"
    "warn"
    "error"
    "trace"
  ], (level) ->
    logger = new CRUD.Logger level
    CRUD.commands.setHandler "log:#{level}", _.bind logger.log, logger

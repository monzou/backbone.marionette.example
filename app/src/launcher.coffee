"use strict"
_        = require "underscore"
Backbone = require "backbone"
CRUD     = require "app/app"

class Launcher

  launch: (root = "") ->
    @setupAnchorHandler root
    @startRouting root
    CRUD.execute "action:users:list" if CRUD.getCurrentRoute() is ""

  setupAnchorHandler: (root ="") ->
    selector = "a[href]:not([data-bypass])"
    $(document).on "click", selector, (e) ->
      href =
        prop: $(@).prop "href"
        attr: $(@).attr "href"
      base = "#{location.protocol}//#{location.host}/#{root}"
      if _.str.startsWith href.prop, base
        e.preventDefault()
        CRUD.navigate href.attr, trigger: true

  startRouting: (root) ->
    Backbone.history.start pushState: true, root: root

launcher = new Launcher
CRUD.on "initialize:after", -> launcher.launch CRUD.Configuration.root

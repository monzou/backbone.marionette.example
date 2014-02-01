class CRUD.Launcher

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
      if _.startsWith href.prop, base
        e.preventDefault()
        CRUD.navigate href.attr, trigger: true

  startRouting: (root) ->
    Backbone.history.start pushState: true, root: root

CRUD.addInitializer ->
  launcher = new CRUD.Launcher
  CRUD.on "initialize:after", -> launcher.launch CRUD.Configuration.root

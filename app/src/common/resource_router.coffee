Common = CRUD.module "Common"

class Common.ResourceRouter extends Marionette.AppRouter

  route: (route, name, callback) ->
    resourceRoute = @toResourceRoute route, name
    @bindHandlers resourceRoute, name
    super r, name, callback for r in [ resourceRoute, "#{resourceRoute}/" ]

  toResourceRoute: (route, name) ->
    route = route.substr(1, route.length) if route.substr(0, 1) is "/"
    resource = _.result @, "resource"
    resourceRoute = resource
    separator = if resource.slice(-1) is "/" then "" else "/"
    if route and route.length > 0
      if route.substr(0, 1) isnt "?"
        resourceRoute += (separator + route)
      else
        resourceRoute += route
    resourceRoute

  bindHandlers: (resourceRoute, name) ->
    @bindRouteHandler resourceRoute, name
    @bindNavigateHandler resourceRoute, name
    @bindActionHandler resourceRoute, name

  bindRouteHandler: (resourceRoute, name) ->
    CRUD.reqres.setHandler "route:#{@resource}:#{name}", (params...) => @routeFor(resourceRoute, params...)

  bindNavigateHandler: (resourceRoute, name) ->
    CRUD.commands.setHandler "navigate:#{@resource}:#{name}", (params...) => CRUD.navigate @routeFor(resourceRoute, params...)

  bindActionHandler: (resourceRoute, name) ->
    CRUD.commands.setHandler "action:#{@resource}:#{name}", (params...) =>
      CRUD.navigate @routeFor(resourceRoute, params...)
      @_getController()?[name]?(params...)

  routeFor: (resourceRoute, params...) ->
    route = CRUD.linkTo resourceRoute
    route = @extractParams route, params
    route = route.replace /(\(|\?|\:|\*).*$/, ""
    route

  extractParams: (route, params) ->
    _.each params, (param) ->
      if _.isArray param
        param = _.map(param, encodeURIComponent).join "/"
      else
        param = encodeURIComponent param
      route = route.replace /(?:\:|\*)[^\/]+/, param
    route


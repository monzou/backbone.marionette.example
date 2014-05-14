"use strict"

LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
modRewrite = require 'connect-modrewrite'
mountFolder = (connect, dir) -> connect.static require("path").resolve(dir)

module.exports = (grunt) ->

  require("load-grunt-tasks")(grunt)

  grunt.initConfig

    browserify:
      vendor:
        files: "app/scripts/vendor.js": [ "app/src/vendor.coffee" ]
        options:
          extensions: [ ".coffee" ]
          transform: [ "coffeeify" ]
          shim:
            "jquery":
              path: "app/bower_components/jquery/dist/jquery.js"
              exports: "$"
            "underscore":
              path: "app/bower_components/underscore/underscore.js"
              exports: "_"
            "underscore.string":
              path: "app/bower_components/underscore.string/lib/underscore.string.js"
              exports: "_s"
              depends:
                "underscore": "underscore"
            "backbone":
              path: "app/bower_components/backbone/backbone.js"
              exports: "Backbone"
              depends:
                "underscore": "underscore"
            "backbone.babysitter":
              path: "app/bower_components/backbone.babysitter/lib/backbone.babysitter.js"
              exports: "Backbone.Babysitter"
              depends:
                backbone: "Backbone"
            "backbone.wreqr":
              path: "app/bower_components/backbone.wreqr/lib/backbone.wreqr.js"
              exports: "Backbone.Wreqr"
              depends:
                backbone: "Backbone"
            "backbone.marionette":
              path: "app/bower_components/marionette/lib/backbone.marionette.js"
              exports: "Backbone.Marionette"
              depends:
                "jquery": "$"
                "backbone": "Backbone"
                "underscore": "_"
            "backbone.stickit":
              path: "app/bower_components/backbone.stickit/backbone.stickit.js"
              exports: "Stickit"
              depends:
                "underscore": "_"
                "backbone": "Backbone"
      app:
        files: "app/scripts/app.js": [ "app/src/main.coffee" ]
        options:
          ignore: [ "app/src/vendor.coffee" ]
          extensions: [ ".coffee" ]
          transform: [ "coffeeify" ]
          aliasMappings: [{
            cwd: "app/src"
            dest: "app"
            src: [ "**/*.coffee" ]
          }]
          external: [
            "jquery"
            "underscore"
            "underscore.string"
            "backbone"
            "backbone.babysitter"
            "backbone.wreqr"
            "backbone.marionette"
            "backbone.stickit"
          ]

    watch:

      options:
        nospawn: true
        livereload: LIVERELOAD_PORT

      app:
        files: [ "app/src/**/*.coffee", "!app/src/vendor.coffee" ]
        tasks: [ "browserify:app" ]

      vendor:
        files: [ "app/src/vendor.coffee" ]
        tasks: [ "browserify:vendor" ]

      livereload:
        files: [ "app/**/*.{html,css,js}" ]
        tasks: []

    connect:
      options:
        port: 9000
        hostname: "localhost"

      livereload:
        options:
          middleware: (connect) ->
            [
              lrSnippet
              modRewrite([
                '!\\.html|\\.js|\\.css|\\.swf|\\.jp(e?)g|\\.png|\\.gif|\\.eot|\\.svg|\\.ttf|\\.woff|\\.otf|\\.json$ /index.html'
              ])
              mountFolder(connect, "app")
            ]

    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"


  grunt.registerTask "default", [
    "browserify"
    "connect:livereload"
    "open"
    "watch"
  ]


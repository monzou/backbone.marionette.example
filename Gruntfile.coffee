"use strict"

LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
modRewrite = require 'connect-modrewrite'
mountFolder = (connect, dir) -> connect.static require("path").resolve(dir)

module.exports = (grunt) ->

  require("load-grunt-tasks")(grunt)

  grunt.initConfig

    watch:

      options:
        nospawn: true
        livereload: LIVERELOAD_PORT

      coffee:
        files: [ "app/src/**/*.coffee" ]
        tasks: [ "coffee:compile" ]

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

    coffee:
      compile:
        files:
          "app/scripts/main.js": [
            "app/src/initializer.coffee"
            "app/src/app.coffee"
            "app/src/launcher.coffee"
            "app/src/lib/**/*.coffee"
            "app/src/common/**/*.coffee"
            "app/src/model/**/*.coffee"
            "app/src/apps/**/common/**/*model.coffee"
            "app/src/apps/**/common/**/*view.coffee"
            "app/src/apps/**/new/*.coffee"
            "app/src/apps/**/edit/*.coffee"
            "app/src/apps/**/index/**/*.coffee"
            "app/src/apps/**/index/*.coffee"
            "app/src/apps/**/*.coffee"
          ]

  grunt.registerTask "default", [
    "coffee:compile"
    "connect:livereload"
    "open"
    "watch"
  ]


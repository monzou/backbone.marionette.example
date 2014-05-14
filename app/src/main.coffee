"use strict"
require "app/launcher"
require "app/apps/header/app"
require "app/apps/users/app"

CRUD = require "app/app"
$ => CRUD.start()
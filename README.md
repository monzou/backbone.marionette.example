# Backbone.Marionette Example

MVVM-flavored example CRUD app with [Backbone.Marionette](https://github.com/marionettejs/backbone.marionette) + [Backbone.stickit](http://nytimes.github.io/backbone.stickit/) + [Browserify](http://browserify.org/).

![image](/image.png?raw=true)

Code here is **work in progress**.

## Concept

* Use [Backbone.Marionette](https://github.com/marionettejs/backbone.marionette)
* Modularize with [Browserify](http://browserify.org/)
* Separate Model and [ViewModel](/app/src/common/view_model.coffee)
* Bind View and ViewModel using [Backbone.stickit](http://nytimes.github.io/backbone.stickit/)
* Data access via [Repository](/app/src/repository)
* Controller is responsible for [application level events](/app/src/apps/users/edit/controller.coffee)
* View is responsible for [DOM level events and bindings](/app/src/apps/users/common/view/user_form.coffee)

## Development

```
$ git clone https://github.com/monzou/backbone.marionette.example.git
$ cd backbone.marionette.example
$ npm install
$ bower install
$ grunt
```

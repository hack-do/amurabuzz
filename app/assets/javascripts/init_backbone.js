//= require libs/backbone
//= require libs/backbone.marionette
//= require libs/backbone-relational
//= require libs/backbone-validation
//= require_tree ./backbone/templates/items/users

//= require ./backbone/app

//= require_tree ./backbone/views/items/users
//= require_tree ./backbone/models
//= require_tree ./backbone/collections
//= require ./backbone/events/tweet_events
//= require ./backbone/controllers/tweet_controller
//= require ./backbone/routers/users_router
//= require ./backbone/routers/tweet_router

$(document).ready(function() {
  return AmuraBuzz.initialize();
});

$(document).on('page:load', function() {
  Backbone.history.stop();
  return AmuraBuzz.initialize();
});

// require_tree ./backbone/templates/items/common
// require ./backbone/templates/layouts/main
// require_tree ./backbone/views/items/common
// require ./backbone/views/layouts/main

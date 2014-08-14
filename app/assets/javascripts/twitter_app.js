var global = {};
window.TwitterApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  vent: _.extend({}, Backbone.Events),
  initialize: function() {
    var router;
    console.log('Backbone Initialize!');
    global.userRouter = new TwitterApp.Routers.Users();
    global.thingRouter = new TwitterApp.Routers.Things();
    return Backbone.history.start({
      pushState: true
    });
  }
};

$(document).ready(function() {
  return TwitterApp.initialize();
});

$(document).on('page:load', function() {
  Backbone.history.stop();
  return TwitterApp.initialize();
});

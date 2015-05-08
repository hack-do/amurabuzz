var global = {};
window.AmuraBuzz = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  vent: _.extend({}, Backbone.Events),
  initialize: function() {
    var router;
    global.userRouter = new AmuraBuzz.Routers.Users();

    return Backbone.history.start({
      pushState: true
    });
  }
};
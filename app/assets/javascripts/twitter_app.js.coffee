window.TwitterApp =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
  	Backbone.history.start()
  	console.log 'Backbone Initialize!'
  	new TwitterApp.Routers.Users()
  	TwitterApp.all_users = new TwitterApp.Models.User()
  	f = TwitterApp.all_users.fetch()
  	console.log(f.responseText)
  	

$(document).ready ->
  TwitterApp.initialize()

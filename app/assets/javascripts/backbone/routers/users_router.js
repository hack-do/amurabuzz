AmuraBuzz.Routers.Users = Backbone.Router.extend({

	 initialize: function() {
	  },

	  routes: {
	    'me/home': 'home',
	    'me/home/': 'home',
	    'backbone/index': 'index',
	    'backbone/show/:id': 'show',
	    'backbone/edit/:id': 'edit',
	    'backbone/delete/:id': 'delete'
	  },


	  show: function(id) {
	    this.user = new AmuraBuzz.Models.User({
	    	id : "asas"
	    });
	     this.userPromise = this.user.fetch({
	      complete: function(xhr ,status){
		     //  this.usersIndexView = new AmuraBuzz.Views.UsersIndex({
			    //   title: "All Users",
			    //   users: xhr.responseJSON
		    	// });
			// this.usersIndexView.render();
			// console.log("View Rendered " + this.usersIndexView.el);

	      },
	      error: function(data){
			}
	    });
	  },

	  edit: function() {
	  },

	  delete: function() {
	  }

});

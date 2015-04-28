AmuraBuzz.Routers.Users = Backbone.Router.extend({

	 initialize: function() {
	 	console.log('Users Router initialized');
	  },

	  routes: {
	    'me/home': 'home',
	    'me/home/': 'home',
	    'backbone/index': 'index',
	    'backbone/show/:id': 'show',
	    'backbone/edit/:id': 'edit',
	    'backbone/delete/:id': 'delete'
	  },
	  
	  index: function() {
	    alert();
	    console.log('index path');
	    this.users = new AmuraBuzz.Collections.Users();
	    console.log("Collections initialized");
	    this.usersPromise = this.users.fetch({
	      complete: function(xhr ,status){
	      		console.log(xhr);
				console.log('users ajax call completed');   
		      this.usersIndexView = new AmuraBuzz.Views.UsersIndex({
			      title: "All Users",
			      users: xhr.responseJSON
		    	});
			
			this.usersIndexView.render();
			console.log("View Rendered " + this.usersIndexView.el);
	      }
	    });
	    console.log("Length : " + this.users.length);
	    
	  },

	  show: function(id) {
	    return console.log('show path (ID : ' + id + ' )');
	    this.user = new AmuraBuzz.Models.User({
	    	id : "asas"
	    });
	    console.log('model initialized'); 
	     this.userPromise = this.user.fetch({
	      complete: function(xhr ,status){
				console.log('users ajax call completed');   
		     //  this.usersIndexView = new AmuraBuzz.Views.UsersIndex({
			    //   title: "All Users",
			    //   users: xhr.responseJSON
		    	// });
			// this.usersIndexView.render();
			// console.log("View Rendered " + this.usersIndexView.el);

	      },
	      error: function(data){
				console.log("Error " + data);
			}
	    });
	  },

	  edit: function() {
	    return console.log('edit path');
	  },

	  delete: function() {
	    return console.log('delete path');
	  }
	
});

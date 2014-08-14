
TwitterApp.Routers.Things = Backbone.Router.extend({
	 initialize: function() {
	 	this.things = new TwitterApp.Collections.Things;
	   	global.thingCollection = this.things;
	 	console.log('Things Router initialized');
	  },

	  routes: {
	  	'backbone/local' : 'local',
	    'backbone/things': 'index',
	     'backbone/things/create': 'create',
	    'backbone/things/show/:id': 'show',
	    'backbone/things/update/:id': 'update',
	    'backbone/things/delete/:id': 'delete'
	  },

	  index: function() {
	   console.log('things : index path');
	   var things = this.things;
	  
	   this.things.fetch().done(function() {
			   	 thingIndexView = new TwitterApp.Views.ThingsIndex({
			   		collection : things,
			   		router : this
			   });
			   	 thingIndexView.render();
		    console.log("Users fetched + view initialized");
		});

	  },

	  create: function(){
  		  	console.log('create path');
	    	var things = this.things;
	    		 this.thingCreateUpdate = new TwitterApp.Views.ThingsCreateUpdate({
			   		type : "Create",
			   		collection : things,
			   		router : this
			   });
    		 this.thingCreateUpdate.render();
	  },

	  show: function(id) {
	    console.log('show path (ID : ' + id + ' )');
	    var things = this.things;
	   
	   	this.things.fetch().done(function() {

	   		var thing = things.get(id);
	   		console.log(thing.toJSON());
			   	 this.thingShowView = new TwitterApp.Views.ThingsShow({
			   		thing : thing.toJSON()
			   });
  	 		this.thingShowView.render();

		});
	  },

	    update: function(id){
  		    console.log('update path (ID : ' + id + ' )');
	    	var things = this.things;

	    	this.things.fetch().done(function() {
	    		var thing = things.get(id);
	    		console.log(thing.toJSON());
	    		 this.thingCreateUpdate = new TwitterApp.Views.ThingsCreateUpdate({
			   		type : "Update",
			   		thing : thing,
			   		collection : things,
			   		router : this
			   	});
    		 this.thingCreateUpdate.render();
		 });
	  },

	  local: function(){
		  	 thing = new TwitterApp.Models.Thing;
		    //-------------------------
		    // thing = new TwitterApp.Models.Thing({
		    // 	name : "cupboard"
		    // });
			//-------------------------
		    // thing.set("name","chair");
		     thing.set({
		    	"name" : "chair"
		    });
		    name  = thing.get("name");
		    category  = thing.get("category");
		    console.log("Name: " + name + ", Category: " + category);

		    thing.save

		    thing.on('change',function(){
		    	console.log("Thing model changed");
		    });

	  }
});

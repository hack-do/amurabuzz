TwitterApp.Views.ThingsShow = Backbone.View.extend({

 	template: JST['things/show'],

	initialize: function(options) {
	    console.log("things show view initialized");
	    console.log(options);
	    // this.collection.on('reset',this.initialize,this);
	    // this.collection.on('change',this.render,this);
	    return this.options = options;
	  },

	  events: {

	  	"click a.delete" : "delete"
	  	// "click tr" : "show"
	  },

	  render: function() {
	    var markup;
	    console.log(" inside view render function ");
	    console.log(this.options.thing);

	    this.$el.html(this.template({
	    	thing : this.options.thing
	    }));

	    console.log(this.$el);
		$('.backbone_main').html(this.$el);
	    
	    return this;
	  },

	   delete: function(e){
	  	e.preventDefault();
	  	console.log(e.target);
	  	var id = $(e.target).closest("a").data("thing-id");
	  	var view = this;
	  	console.log(id);

	    	global.thingCollection.fetch().done(function() {
	    		var thing = global.thingCollection.get(id);
	    		console.log(thing.toJSON());
				if(confirm("Delete Thing : " + thing.toJSON().name +" ?") == true)
				{
					thing.destroy();
					console.log("deleted ");
					global.thingRouter.navigate('/backbone/things',true);
				}
				
		 });
	  }

});

TwitterApp.Views.ThingsIndex = Backbone.View.extend({

 	template: JST['things/index'],

	initialize: function(options) {
	    console.log("things index view initialized");
	    console.log(global.thingCollection);
	    // this.listenTo(global.thingCollection, 'change', this.render);
	    global.thingCollection.on('remove',this.render,this);
	    global.thingCollection.on('add',this.render,this);
	    global.thingCollection.on('reset',this.render,this);
	    console.log("events done");
	    this.options = options;
	    return this;
	  },

	  events: {

	  	// "click tr" : "show",
	  	"mouseenter tr" : "highlight",
	  	"mouseleave tr" : "normal",
	  	"click a.delete" : "delete"
	  },

	  render: function() {
	    var markup;
	    console.log(" view render function ");
	    console.log(this.options.collection.toJSON());

	    this.$el.html(this.template({
	    	things : this.options.collection.toJSON()
	    }));
		$('.backbone_main').html(this.$el);
	    
	    	return this;
	  },

	  show: function(e){
	  		console.log("clicked..");
	  		console.log(e.target);
	  },

	  delete: function(e){
	  	e.preventDefault();
	  	console.log(e);
	  	var tr = $(e.target).closest("tr");
	  	var id = $(tr).data("thing-id");
	  	var view = this;
	  	console.log(id);

	  	var things = this.collection;
	    	this.collection.fetch().done(function() {
	    		var thing = things.get(id);
	    		console.log(thing.toJSON());
    			if(confirm("Delete Thing : " + thing.toJSON().name +" ?") == true)
    			{
    				thing.destroy();
    				//things.save();
    				console.log("deleted ");

    				global.thingRouter.navigate('/backbone/things',true);
    			}
    			
		 });
	  },

	  highlight: function(e){
	  	var tr = $(e.target).closest("tr");
	  	$(tr).addClass("text-primary");
	  	$(tr).addClass("primary");
	  },

	   normal: function(e){
	  	var tr = $(e.target).closest("tr");
	  	$(tr).removeClass("text-primary");
	  	$(tr).removeClass("primary");
	  },


});

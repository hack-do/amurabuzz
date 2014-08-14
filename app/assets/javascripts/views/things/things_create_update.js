TwitterApp.Views.ThingsCreateUpdate = Backbone.View.extend({

 	template: JST['things/create_or_update'],

	initialize: function(options) {
	    console.log("view create/update things initialized");
	    console.log("Type : " + options.type);
	    global.thingCollection.on('remove',this.render,this);
	    global.thingCollection.on('add',this.render,this);
	    //global.thingCollection.on('change',this.render,this);
	    return this.options = options;
	  },

	  events: {

	  	"click button#thing_create_update_button_backbone" : "create_or_update"
	  },

	  render: function() {
	    var markup;
	    console.log(" create/update render function ");
	    console.log(this.options.type);

	    var thing_JSON;

	    if(this.options.thing)
	    {
	    	thing_JSON = this.options.thing.toJSON();	
	    }

	    this.$el.html(this.template({
	    	type : this.options.type,
	    	thing : thing_JSON
	    }));
		$('.backbone_main').html(this.$el);
	    
	    	return this;
	  },

	  create_or_update: function(e){
	  	e.preventDefault();
	  	var name = "";
	  	name = $('input#thing_name_backbone').val();
	  	var category = "";
	  	category = $('input#thing_category_backbone').val(); 
	  	console.log("Name : " + name + " Category " + category);

	  	if(this.options.type == 'Create') {
	  			console.log("create method");

	  			var new_thing  = new TwitterApp.Models.Thing({
	  				name : name,
				  	category : category,
				  	validate : true
	  			});
	  			console.log(new_thing.isValid());

				if(new_thing.isValid() == true)
				{
					console.log("valid !!!!!!!!!!!!!!!!!!!!!!!!");
					var promise1 = new_thing.save().done(function(e){
				  		console.log("promise done");
				  		global.thingRouter.navigate("/backbone/things",true);
				  	}).fail(function(data){
				  		console.log("promise failed");
				  		console.log(data);
				  		var errors = data.responseJSON;
			  			$(".backbone_errors").html("<h4>Errors :</h4>");
			  			_.each(errors, function(error,attr){
						  	// console.log(error + " - " + attr);
						 $(".backbone_errors").append("<p>" + attr + " - " + error + "</p>");
						});
				  	});
				}
	  	}
	  	else if(this.options.type == 'Update') {
	  			console.log("update method");


		  		var Promise2 = this.options.thing.save({
		  			name : name,
		  			category : category
		  		}).done(function(e){
		  			console.log("promise done");
		  			global.thingRouter.navigate("/backbone/things",true);
		  		}).fail(function(data){
			  		console.log("promise failed");
			  		console.log(data);
			  		var errors = data.responseJSON;
		  			$(".backbone_errors").html("<h4>Errors :</h4>");
		  			_.each(errors, function(error,attr){
					  	// console.log(error + " - " + attr);
					 $(".backbone_errors").append("<p>" + attr + " - " + error + "</p>");
					});
		  		});
	  	}  	
	  }

});

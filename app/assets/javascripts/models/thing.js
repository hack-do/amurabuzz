TwitterApp.Models.Thing = Backbone.Model.extend({
	// defaults: {
	// 	name : "table",
	// 	category : "furniture"
	// },
	urlRoot : "/things",

	 // validate: {
	 //    name: {
	 //      required: true
	 //      // pattern   : /[a-zA-Z]+/,
	 //      // minlength : 1,
	 //      // maxlength : 100
	 //    },
	 //    category: {
	 //      required: true
	 //      // pattern   : /[a-zA-Z]+/,
	 //      // minlength : 1,
	 //      // maxlength : 100
	 //    }
  // 	},

  	initialize: function(){
	  		 this.on("invalid", function(model, error){
	  		 	console.log("invalid thing");
	        console.log(error);
	        //$(".backbone_errors").html(error);
	         $(".backbone_errors").html("<h4>Errors :</h4><p>" + error + "</p>");
	    });
  	},

  // 	initialize: function(attributes, options) {
  //   options || (options = {});
  //   _.bindAll(this, 'defaultErrorHandler');
  //   this.bind("error", this.defaultErrorHandler);
  //   this.init && this.init(attributes, options);
  // },

	    validate: function (attrs) {
	    	console.log("Validation");
	    	console.log(attrs);
        if (attrs.name == "") {
        	console.log("name blank !");
            return 'Insert a name';
            //return false;
        }
        if (attrs.category == "") {
            return 'Insert a category';
        }
        return '';
    }

     // defaultErrorHandler: function(model, error) {
     // 	console.log("Error Handler");
     // 	console.log(model);
     // 	console.log(error);
     // }
	// url: function () {
	// 	console.log(this);
 //      var base =
 //        _.result(this, 'urlRoot') ||
 //        _.result(this.collection, 'url') ||
 //        urlError();
 //      if (this.isNew()) return base;
 //      return base.replace(/([^\/])$/, '$1/') + encodeURIComponent(this.id);
 //    },
 //    sync: function(method, model, options) {
	// 	options = options || {};
	// 	options.url = model.methodToURL(method.toLowerCase());
	// 	return Backbone.sync.apply(this, arguments);
	// }
});

AmuraBuzz.Views.UsersIndex = Backbone.View.extend({

	  template: JST['users/index'],

	  initialize: function(options) {
	    return this.options = options;
	  },

	  events: {

	  	"click tr" : "show"
	  },

	  render: function() {
	    var markup;
		// $.each(this.options.users, function(i, item) {
		//     console.log(item);
		//     markup += '<tr><td>' + item.email + '</td></tr>';
		// });

	    this.$el.html(this.template({
	    	users: this.options.users
	    }));



	    $('#all_users_backbone').html(this.$el);
	    return this;
	  },

	  show: function(){
	  }

});

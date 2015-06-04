//= require jquery
//= require jquery_ujs
//= require turbolinks

//= require bootstrap
//= require underscore
//= require jquery.noty
//= require select2
//= require jquery.transit.min

//= require amura
//= require init_backbone.js
//= require chat_app
//= require tweet

$(document).on('page:change', function() {
	if(!_.isEmpty(current_user)){	
		Chat.init();
	}
});

// $(document).on('page:fetch', function() {
// });

// $(document).on('page:receive', function() {
// });
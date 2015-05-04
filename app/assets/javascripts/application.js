//= require jquery
//= require jquery_ujs
//= require turbolinks

//= require libs/bootstrap
//= require libs/underscore
//= require libs/jquery.noty
//= require libs/select2
// require jquery.transit

//= require amura
//= require init_backbone.js

function initialize(){
	//$('#main_body').hide();
	$('#spinner').hide();

 	$('#post_tweet').attr('disabled','disabled');	

 	$('#tweet_msg').keydown(function(e){
	 	var msg_len = $(this).val().length;
	 	$('#tweet_len').text(160 - msg_len);
	 	if(msg_len > 0){
 			$('#post_tweet').removeAttr('disabled');
	 	}else{
	 		$('#post_tweet').attr('disabled','disabled');	
	 	}
	    if (e.keyCode == 13 && $(this).val()!= "") {
	        this.form.submit();
	        return false;
	     }
 	});
};

// $(document).ready(function() {	

// });

$(document).on('page:change', function() {
  initialize();
});

$(document).on('page:fetch', function() {

  $('#main_body').css("opacity","0.3");
  $('#main_body').css("z-index","-5");
  $('#spinner').css("z-index","10");
  $('#spinner').show();
});

$(document).on('page:receive', function() {

   $('#main_body').css("opacity","1");
   $('#main_body').css("z-index","10");
   $('#spinner').css("z-index","-5");
   $('#spinner').hide();
});

//= require jquery
//= require jquery_ujs
//= require turbolinks

//= require bootstrap
//= require underscore
//= require jquery.noty
//= require select2
// require jquery.transit

//= require faye

//= require amura
//= require init_backbone.js

$(document).on('page:change', function() {
 	
 	$('#tweet_content').on('input',function(e){
	 	var msg_len = $(this).val().length;
	 	$('#tweet_len').text(160 - msg_len);
	 	if(msg_len > 0){
 			$('#post_tweet').removeAttr('disabled');
	 	}else{
	 		$('#post_tweet').attr('disabled','disabled');	
	 	}
 	});

	$("#tweet_modal").on("hidden.bs.modal", function(){
		$('#tweet_content').val("").trigger('input');
	});

	$("#tweet_modal").on("show.bs.modal", function(e){
	    if (e.keyCode == 13 && $(this).val()!= "") {
	        this.form.submit();
	        return false;
	     }
	});

  	$("#post_tweet").click(function(){
		var tweet_id = $("#tweet_modal").data("tweet-id")
		
		if(!Amura.blank(tweet_id)){
			var url = "/users/me/tweets/"+tweet_id;
			var type = "PUT"
		}else{
			var url = "/users/me/tweets";
			var type = "POST"			
		}

		$.ajax({
			url: url,
			data: {tweet: {content: $("#tweet_content").val()}},
			type: type,
			dataType: "json",
			success: function(fonts,status,errors){
				$('#tweet_modal').modal('hide');
				Amura.global_success_handler("Tweet Posted !");
			}
		});
	});

	$(".edit-tweet").click(function(e){
		var $tweet = $(this).closest(".tweet");
		var tweet_id = $tweet.data("id");
		var tweet_content = $tweet.find(".tweet-content").text().trim();
		if(!Amura.blank(tweet_id)){
			$("#tweet_content").val(tweet_content).trigger('input');
			$("#tweet_modal").data("tweet-id",tweet_id).modal("show");
		}
	});

	// var source = new EventSource('/users/me/tweets/67/stream');
	// source.addEventListener('message',function(e){
	//   console.log("message received !!!! ", e);
	//   // message = JSON.parse(e.data);
	// });
	// source.addEventListener('open', function(e) {
	//   // console.log("stream opened", e);
	// }, false);

	// source.addEventListener('error', function(e) {
	//   if (e.readyState == EventSource.CLOSED) {
	//   	console.log("stream closed", e);
	//   }
	// }, false);
	// source.onmessage = function(event) {
	//     console.log("onmessage : ", event);
	// };

});

// $(document).on('page:fetch', function() {
// });

// $(document).on('page:receive', function() {
// });
$(document).on('page:change', function() {
	$('#tweet-input').on('input',function(e){
	 	var msg_len = $(this).val().length;
	 	$('#tweet_len').text(160 - msg_len);
	 	if(msg_len > 0){
				$('#post_tweet').removeAttr('disabled');
	 	}else{
	 		$('#post_tweet').attr('disabled','disabled');	
	 	}
	});

	$("#tweet_modal").on("hidden.bs.modal", function(){
		$('#tweet-input').val("").trigger('input');
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
			data: {tweet: {content: $("#tweet-input").val()}},
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
			$("#tweet-input").val(tweet_content).trigger('input');
			$("#tweet_modal").data("tweet-id",tweet_id).modal("show");
		}
	});
});
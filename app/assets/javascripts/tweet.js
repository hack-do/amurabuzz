$(document).ready(function() {
// $(document).on('page:change', function() {
	var fetching = 0;
	if($(".tweets-pagination-box").length > 0){
    function processScroll() {
			if(($(window).scrollTop() > $(document).height() - $(window).height() - 50) && fetching == 0){
				var url =  $(".pagination .next_page a").attr("href");
				if(!_.isEmpty(url)){
					var page = page = url.match(/page=\d*/)[0].replace("page=","");
					var page_url = "/users/me/tweets?page=" + page;
					fetching = 1;
					$.getScript(page_url).done(function(){
						fetching = 0;
					});
				}
			}
    }
		var throttled = _.throttle(processScroll, 500);
		$(window).scroll(throttled);
	}

	$('.tweet-input').on('input',function(e){
	 	var msg_len = $(this).val().length;
	 	var $tweet_form = $(this).closest(".post-tweet-form");

	 	$tweet_form.find('.tweet-length').text(160 - msg_len);
	 	var disabled = msg_len > 0 ? '' : 'disabled';
 		$tweet_form.find('.post-tweet').prop('disabled', disabled);
	});

	$("#tweet_modal").on("hidden.bs.modal", function(){
		$(this).find('.tweet-input').val('').trigger('input');
	});

	$("#tweet_modal").on("show.bs.modal", function(e){
    if(e.keyCode == 13 && $(this).val()!= '') {
        this.form.submit();
        return false;
     }
	});

	$(document).on("submit", ".post-tweet-form", function(e){
		e.preventDefault();
		var form = this;
		var tweet_id = $(form).find("[name='id']").val();

		$(form).validate();

		if($(form).valid()){
			if(!Amura.blank(tweet_id)){
				var url = "/users/me/tweets/"+tweet_id;
				var type = "PUT"
			}else{
				var url = "/users/me/tweets";
				var type = "POST"
			}

			$.ajax({
				url: url,
				dataType: "script",
				type: type,
				data: $(form).serialize(),
				success: function(tweet, status, errors){
					$(form).find(".tweet-input").val('');
					$(form).trigger("after-submit");
				},error: function(one, two, three){
					Amura.global_error_handler(one.responseJSON);
				}
			});
		}
	});

	Amura.init_file_uploader($(".media-upload"), {
		data_type: 'json',
    type: 'POST',
    form_data: {
      folder: "Tweet Pictures",
      image_type: "tweet_picture"
    },
    dropzone: $(".post-tweet-form"),
    on_add: function (e, data) {
      console.log("on_add : ", data);

    	if(data.files[0].type.match(/jpg|png|jpeg/i)){
				var html = "<span>"+data.files[0].name+"</span>";
	      $(".fileinput-files").html(html);
	      	$(".post-tweet-form").on("after-submit",function(e){
						console.log(data);
						data.formData = {
							folder: "Tweet Pictures",
							image_type: "tweet_picture",
							tweet_id: $(".post-tweet-form").find("[name='id']").val()
						}
      			data.submit();
	      	});
    	}else{
    		$(".media-upload").empty();
    		Amura.global_error_handler("Invalid file type '"+data.files[0].type+"', allowed file types are 'jpg, png, jpeg'. ");
    		return false;
    	}

    },

    on_start: function(e, data){
    	console.log("on_start : ", data);
    },
    on_progress: function(e, data){
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $(".asset-loading").find(".progress-bar").css("width", progress + "%");
    },
    on_success: function(e, data){
      console.log("on_success ; ", data.result);
    },
    on_error: function(errors){
      Amura.global_error_handler(errors);
    }
	});

	$(document).on("click", ".edit-tweet", function(e){
		var $tweet_panel = $(this).closest(".tweet-panel");
		var tweet_id = $tweet_panel.data("id");
		var tweet_content = $tweet_panel.find(".tweet-content").text().trim();

		if(!Amura.blank(tweet_id)){
			$("#tweet_modal .tweet-input").val(tweet_content).trigger('input');
			$("#tweet_modal").find("[name='id']").val(tweet_id);
			$('#tweet_modal').modal("show");
		}
	});

	// TODO :: throw error if operation not permitted !
	$(document).on("click", ".post-vote", function(e){
		var $tweet_panel = $(this).closest(".tweet-panel");
		var tweet_id = $tweet_panel.data("id");
		var vote_value = $(this).data("value");

		if(!Amura.blank(tweet_id) && !Amura.blank(vote_value)){
			$.ajax({
				url: "/users/me/tweets/"+tweet_id+"/votes",
				data: {vote: {value: vote_value}},
				type: "POST",
				dataType: "script",
				success: function(vote, status, errors){
					// Amura.global_success_handler("Vote Posted !");
				},error: function(one,two){
					Amura.global_error_handler(one.responseJSON);
				}
			});
		}
	});

	$(document).on("click", ".post-comment", function(e){
		var $tweet_panel = $(this).closest(".tweet-panel");
		var tweet_id = $tweet_panel.data("id");
		var comment_content = $tweet_panel.find(".comment-input").val().trim();
		var comment_id = '';
		if(!Amura.blank(tweet_id) && !Amura.blank(comment_content)){
			if(!Amura.blank(comment_id)){
				var url = "/users/me/tweets/"+tweet_id+"/comments/"+comment_id;
				var type = "PUT"
			}else{
				var url = "/users/me/tweets/"+tweet_id+"/comments";
				var type = "POST"
			}

			$.ajax({
				url: url,
				data: {comment: {content: comment_content}},
				type: type,
				dataType: "script",
				success: function(comment, status, errors){
					// Amura.global_success_handler("Comment Posted !");
				},error: function(one, two, three){
					Amura.global_error_handler(two);
				}
			});
		}
	});

	$(document).on("click", ".post-share", function(e){
		if(confirm("Do you want to share this tweet ?")){
			var $tweet_panel = $(this).closest(".tweet-panel");
			var tweet_id = $tweet_panel.data("id");
			var vote_value = $(this).data("value");

			if(!Amura.blank(tweet_id)){
				$.ajax({
					url: "/users/me/tweets/"+tweet_id+"/shares",
					type: "POST",
					dataType: "json",
					success: function(tweet, status, errors){
						console.log(status);
						Amura.global_success_handler("Tweet Shared !");
					},error: function(one, two, three){
						Amura.global_error_handler(one.responseJSON);
					}
				});
			}
		}
	});

	$(document).on("click", ".get-all-likes", function(e){
		var $tweet_panel = $(this).closest(".tweet-panel");
		var tweet_id = $tweet_panel.data("id");

		if(!Amura.blank(tweet_id)){
			$.ajax({
				url: "/users/me/tweets/"+tweet_id+"/votes",
				type: "GET",
				dataType: "script",
				success: function(likes, status, errors){
					// Amura.global_success_handler("Vote Posted !");
				},error: function(one, two, three){
					Amura.global_error_handler(one.responseJSON);
				}
			});
		}
	});

	$(document).on("mouseover", ".get-all-likes", function(e){
		var $tweet_panel = $(this).closest(".tweet-panel");
		var tweet_id = $tweet_panel.data("id");

		if(!Amura.blank(tweet_id)){
			$.ajax({
				url: "/users/me/tweets/"+tweet_id+"/votes",
				type: "GET",
				dataType: "json",
				success: function(likes, status, errors){
					var users = _.map(likes, function(like){
						return like.user.user_name;
					})
					$(e.target).tooltip({
						html: true,
						trigger: 'manual',
						title: users.join(", "),
					})
					$(e.target).tooltip('show')
				},error: function(one, two, three){
					Amura.global_error_handler(one.responseJSON);
				}
			});
		}
	});

	$(document).on("click", ".get-comments", function(e){
		var $tweet_panel = $(this).closest(".tweet-panel");
		$tweet_panel.find(".comments-box").toggleClass("hidden");
	});

	$(document).on("click", ".get-all-comments", function(e){
		var $tweet_panel = $(this).closest(".tweet-panel");
		var tweet_id = $tweet_panel.data("id");

		if(!Amura.blank(tweet_id)){
			$.ajax({
				url: "/users/me/tweets/"+tweet_id+"/comments",
				type: "GET",
				dataType: "script",
				success: function(comments, status, errors){
					// Amura.global_success_handler("Vote Posted !");
				},error: function(one, two, three){
					Amura.global_error_handler(one.responseJSON);
				}
			});
		}
	});

	$(document).on("click", ".get-all-shares", function(e){
		var $tweet_panel = $(this).closest(".tweet-panel");
		var tweet_id = $tweet_panel.data("id");

		if(!Amura.blank(tweet_id)){
			$.ajax({
				url: "/users/me/tweets/"+tweet_id+"/shares",
				type: "GET",
				dataType: "script",
				success: function(comments, status, errors){
					// Amura.global_success_handler("Vote Posted !");
				},error: function(one, two, three){
					Amura.global_error_handler(one.responseJSON);
				}
			});
		}
	});
});
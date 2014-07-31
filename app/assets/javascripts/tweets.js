$(document).on('page:change', function() {
	//console.log($(".likes_popover").data("likes"));
	$(".likes_popover").hover(function(){
		$(this).popover({
		    title: "",
		    content: $(this).data("likes"),
		    trigger: "hover"
		});
	});

	$(".tweet_likes_hidden_wrapper").css("display","none");

	$("button.tweet_likes").click(function(){
		b_id = $(this).attr("id");
		div_id = "t" + b_id;
		var likes = $("div#"+ div_id);
		$("#like_modal_body").html(likes);
		//console.log(likes);
	});

});
var Chat = {active_chats: []};

Chat.init = function(){
	$.ajax({
			url: '/users/'+current_user.id+'/chats/init',
			type: 'GET',
			dataType: "json",
			success: function(friends,status,errors){
			    var html = "";
			    _.each(friends,function(f){
			        html += '<li class="list-group-item chat-friend">\
			            <a class="btn btn-link btn-sm start_chat" href="#" data-user-id="'+ f.id+'">'+f.name+'</a>\
			        </li>';
			    });
			    $("#friends_list").html(html);
			    Chat.init_events();
			    $("#chat-app").removeClass("hidden");
			},
			error: function(data,status,errors){
				console.log(errors);
			}
	});			

}
Chat.init_events = function(){

	PrivatePub.subscribe("/chats/"+current_user.id, function(data, channel) {
	  // console.log(data);
	  if(data.user_id == current_user.id){
	  	data.user_name = 'me';
	  }	
      if(_.include(Chat.active_chats,data.recipient_id)){
	  	Chat.maximize($("#chatbox"+data.recipient_id));
	  }else{
	  	Chat.open(data.recipient_id,data.recipient_name);
	  }
  	  Chat.attach_message($("#chatbox"+data.recipient_id),data);
	});

	$(".start_chat").click(function(e){
        e.preventDefault();
		Chat.open($(this).data('user-id'),$(this).text().trim());		
	});

	$('#chat-area').on('input','.message-input',function(e){
		var $chatbox = $(this).closest('.chatbox');
	 	var msg_len = $(this).val().length;
	 	if(msg_len > 0){
 			$chatbox.find('.send-message').removeAttr('disabled');
	 	}else{
	 		$chatbox.find('.send-message').attr('disabled','disabled');	
	 	}
 	});

	$('#chat-area').on('click','.toggle-chat',function(e){
		e.preventDefault();
		Chat.toggle($(this).closest('.chatbox'));
	});

	$('#chat-area').on('click','.close-chat',function(e){
		e.preventDefault();
		Chat.close($(this).closest('.chatbox'));
	});

	$('#chat-area').on('keydown','.message-input',function(e){
		if (e.keyCode==13){
	        e.preventDefault();
			var $chatbox = $(this).closest('.chatbox');
	        $chatbox.find('.send-message').trigger('click');
	    }
	});

	$('#chat-area').on('click','.send-message',function(e){
		e.preventDefault();
		Chat.send_message($(this).closest('.chatbox'));
	});	
}

Chat.open = function(recipient_id,recipient_name){
    if(_.include(Chat.active_chats,recipient_id)){
	    var $chatbox = $("#chatbox"+recipient_id)
    	Chat.maximize($chatbox);
    }else if(Chat.active_chats.length <= 2){
	    var html = "<div class='col-md-4 pull-right chatbox' id='chatbox"+recipient_id+"' data-state='open' data-recipient-id="+recipient_id+">\
			<div class='panel panel-default'>\
		        <div class='panel-heading clearfix'>\
		            <div class='panel-title'>\
		                <span class='chat-recipient'>"+recipient_name+"</span>\
		                <div class='chat-actions pull-right'>\
		                    <a href='#' class='btn btn-link toggle-chat'><i class='fa fa-minus'></i></a>\
		                    <a href='#' class='btn btn-link close-chat'><i class='fa fa-times'></i></a>\
		                </div>\
		            </div>\
		        </div>\
		        <div class='panel-body'></div>\
		        <div class='panel-footer clearfix'>\
		            <div class='input-group'>\
		                <textarea class='form-control message-input' rows='1' ></textarea>\
		                <div class='input-group-btn'>\
		                    <button class='btn btn-primary send-message' disabled><i class='fa fa-paper-plane fa-1'></i></button>\
		                </div>\
		            </div>\
		        </div>\
	        </div>\
	    </div>";

	    $("#chat-area").append(html);
	    
	    var $chatbox = $("#chatbox"+recipient_id)
	    $chatbox.css('margin-top', $chatbox.parent().height()-$chatbox.height())

	    Chat.active_chats.push(recipient_id);
    }
}
Chat.close = function($chatbox){
	var recipient_id = $chatbox.data("recipient-id");
	Chat.active_chats.splice(Chat.active_chats.indexOf(recipient_id));
	$chatbox.remove();
}
Chat.minimize = function($chatbox){
	if($chatbox.length == 1){
		if($chatbox.data("state") == "closed"){
			$chatbox.transition({ y: ($('.chatbox').height() - 40) });
			$chatbox.data('state','open');
		}
	}
}
Chat.maximize = function($chatbox){
	if($chatbox.length == 1){
		if($chatbox.data("state") == "closed"){
			$chatbox.transition({ y: 0 });
			$chatbox.data('state','open');
			$chatbox.find(".message-input").focus();
		}
	}
}
Chat.toggle = function($chatbox){
	if($chatbox.length == 1){
		if($chatbox.data('state') == 'open'){
			$chatbox.transition({ y: ($('.chatbox').height() - 40) });
			$chatbox.data('state','closed');
		}else if($chatbox.data('state') == 'closed'){
			$chatbox.transition({ y: 0 });			
			$chatbox.data('state','open');
		}
	}
}
Chat.attach_message = function($chatbox,data){
  	var html = "<ul class='message-box list-unstyled'>\
	                <li>\
	                    <span><span class='user-name'>"+data.user_name+"</span>:</span>\
	                    <span class='message'>"+data.message+"</span>\
	                </li>\
	            </ul>";
	$chatbox.find(".panel-body").append(html);
	$('.chatbox').each(function() {
	    $(this).css('margin-top', $(this).parent().height()-$(this).height())
	});
}
Chat.send_message = function($chatbox){
	if($chatbox.length == 1){
		var recipient_id = $chatbox.data("recipient-id");		
		if(!Amura.blank(recipient_id)){
			$.ajax({
				url: '/users/'+current_user.id+'/chats',
				data: {message: $chatbox.find(".message-input").val(),recipient_id: recipient_id},
				type: 'POST',
				dataType: "json",
				success: function(data,status,errors){
					var $panelbody = $chatbox.find(".panel-body")
					$chatbox.find('.message-input').val("").trigger("input");
					$panelbody.scrollTop($panelbody[0].scrollHeight);
				},
				error: function(data,status,errors){
					$('.message-input').addClass("has-error");
				}
			});			
		}
	}
}
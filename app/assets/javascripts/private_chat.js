var ChatApp = {
	active_chats: [],
	friends_list_container: "friends-list-container",
	friends_list: "friends-list",
	chat_app_container: "chat-app-container",
	chat_app: "chat-app",
	chatbox_prefix: "chatbox",
	provider: "WebSocket",
	// provider: "PrivatePub"
};

ChatApp.init = function(){
	var provider_working = false;
	if(ChatApp.provider == "WebSocket"){
		provider_working = !!window.WebSocket;
	}else{
		provider_working = !!window.PrivatePub;
	}

	if(provider_working){
		ChatApp.init_friends();
		ChatApp.init_events();

		$("#"+ChatApp.chat_app_container).removeClass("hidden");
	}else{
		Amura.global_error_handler("Update your browzer !");
	}
}

ChatApp.destroy = function(){
	$("#"+ChatApp.chat_app_container).remove();
	$("#"+ChatApp.friends_list_container).remove();
}
ChatApp.disable = function(){
	$("#"+ChatApp.chat_app_container).addClass("hidden");
	$("#"+ChatApp.friends_list_container).addClass("hidden");
}
ChatApp.init_friends = function(){
	$.ajax({
			url: '/users/'+current_user.id+'/friends',
			type: 'GET',
			dataType: "json",
			success: function(friends,status,errors){
			    var html = "";
			    _.each(friends, function(friend){
			        var label = friend.online_status == true ? "success" : "default";
			        html += '<li class="list-group-item btn btn-default start_chat" data-user-id="'+ friend.id+'">\
			        <img class="img-xs" src="'+friend.profile_picture.thumb_file_url+'" alt="'+friend.profile_picture.file_file_name+'">\
			        <span class="label label-'+label+'">'+friend.user_name+'</span>\
			        </li>';
			    });
			    $("#"+ChatApp.friends_list).html(html);
			    $("#"+ChatApp.friends_list_container).removeClass("hidden");
			},
			error: function(data,status,errors){
			}
	});
}
ChatApp.init_events = function(){

	ChatApp[ChatApp.provider].init_events();

	$("#"+ChatApp.friends_list).on("click",".start_chat",function(e){
		e.preventDefault();
		ChatApp.open($(this).data('user-id'),$(this).text().trim());
	});

	$('#'+ChatApp.chat_app).on('input','.message-input',function(e){
		var $chatbox = $(this).closest('.'+ ChatApp.chatbox_prefix);
	 	var msg_len = $(this).val().length;
	 	if(msg_len > 0){
 			$chatbox.find('.send-message').removeAttr('disabled');
	 	}else{
	 		$chatbox.find('.send-message').attr('disabled','disabled');
	 	}
 	});

	$('#'+ChatApp.chat_app).on('click','.toggle-chat',function(e){
		e.preventDefault();
		ChatApp.toggle($(this).closest('.'+ ChatApp.chatbox_prefix));
	});

	$('#'+ChatApp.chat_app).on('click','.close-chat',function(e){
		e.preventDefault();
		ChatApp.close($(this).closest('.'+ ChatApp.chatbox_prefix));
	});

	$('#'+ChatApp.chat_app).on('keydown','.message-input',function(e){
		if (e.keyCode==13){
      e.preventDefault();
			var $chatbox = $(this).closest('.'+ ChatApp.chatbox_prefix);
      $chatbox.find('.send-message').trigger('click');
    }
	});

	$('#'+ChatApp.chat_app).on('click','.send-message',function(e){
		e.preventDefault();
		ChatApp.send_message($(this).closest('.'+ ChatApp.chatbox_prefix));
	});
}

ChatApp.open = function(recipient_id,recipient_name){
    if(_.include(ChatApp.active_chats,recipient_id)){
	    var $chatbox = $("#" + ChatApp.chatbox_prefix+recipient_id)
    	ChatApp.maximize($chatbox);
    }else if(ChatApp.active_chats.length <= 2){
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

	    $("#"+ChatApp.chat_app).append(html);

	    var $chatbox = $("#" + ChatApp.chatbox_prefix+recipient_id)
	    $chatbox.css('margin-top', $chatbox.parent().height()-$chatbox.height())

	    ChatApp.active_chats.push(recipient_id);
    }
}
ChatApp.close = function($chatbox){
	var recipient_id = $chatbox.data("recipient-id");
	ChatApp.active_chats.splice(ChatApp.active_chats.indexOf(recipient_id));
	$chatbox.remove();
}
ChatApp.minimize = function($chatbox){
	if($chatbox.length == 1){
		if($chatbox.data("state") == "closed"){
			$chatbox.transition({ y: ($('.'+ ChatApp.chatbox_prefix).height() - 40) });
			$chatbox.data('state','open');
		}
	}
}
ChatApp.maximize = function($chatbox){
	if($chatbox.length == 1){
		if($chatbox.data("state") == "closed"){
			$chatbox.transition({ y: 0 });
			$chatbox.data('state','open');
			$chatbox.find(".message-input").focus();
		}
	}
}
ChatApp.toggle = function($chatbox){
	if($chatbox.length == 1){
		if($chatbox.data('state') == 'open'){
			$chatbox.transition({ y: ($('.'+ ChatApp.chatbox_prefix).height() - 40) });
			$chatbox.data('state','closed');
		}else if($chatbox.data('state') == 'closed'){
			$chatbox.transition({ y: 0 });
			$chatbox.data('state','open');
		}
	}
}
ChatApp.attach_message = function($chatbox,data){
	var html = "<ul class='message-box list-unstyled'>\
                <li>\
                  <span><span class='user-name'>"+data.person_name+"</span>:</span>\
                  <span class='message'>"+data.message+"</span>\
	              </li>\
	            </ul>";
	$chatbox.find(".panel-body").append(html);
	$('.'+ ChatApp.chatbox_prefix).each(function() {
	    $(this).css('margin-top', $(this).parent().height()-$(this).height())
	});
}
ChatApp.send_message = function($chatbox){
	if($chatbox.length == 1){
		var sender_id = current_user.id;
		var sender_name = current_user.user_name;
		var recipient_id = $chatbox.data("recipient-id");
		var recipient_name = $chatbox.data("recipient-name");
		var message = $chatbox.find(".message-input").val();
		message = ChatApp.formatMessage(message);

		if(_.include(["PrivatePub","WebSocket"],ChatApp.provider)){
			ChatApp[ChatApp.provider].send_message($chatbox, sender_id, recipient_id, message);
		}
	}
}
ChatApp.on_new_message = function(data){
  // data.room
  // data.participants
  console.log("private on_new_message : ", data)
	if(data.sender_id == current_user.id){
  	data.person_name = 'me'; // data.recipient_name;
  	data.person_id = data.recipient_id;
  }else{ //  if(data.recipient_id == current_user.id)
  	data.person_id = data.sender_id;
  	data.person_name = data.sender_name;
  }
  if(_.include(ChatApp.active_chats,data.person_id)){
  	ChatApp.maximize($("#" + ChatApp.chatbox_prefix+data.person_id));
  }else{
  	ChatApp.open(data.person_id,data.person_name);
  }
  ChatApp.attach_message($("#" + ChatApp.chatbox_prefix+data.person_id),data);
}

ChatApp.PrivatePub = {};
ChatApp.PrivatePub.init_events = function(){
	PrivatePub.subscribe("/chats/"+current_user.id, function(data, channel) {
	  // console.log(data);
	  ChatApp.on_new_message(data);
	});
}
ChatApp.PrivatePub.send_message = function($chatbox, sender_id, recipient_id, message){
	// var c = PrivatePub.fayeClient
	// c.publish('/chat', {message: 'Hi'}, {attempts: 3});

	// send message via PrivatePub
	$.ajax({
		url: '/users/'+sender_id+'/chats/send_message',
		data: {message: message,recipient_id: recipient_id},
		type: 'POST',
		dataType: "json",
		success: function(data,status,errors){
			var $panelbody = $chatbox.find(".panel-body")
			$chatbox.find('.message-input').val("").trigger("input");
			$panelbody.scrollTop($panelbody[0].scrollHeight);
		},
		error: function(data,status,errors){
			$chatbox.find('.message-input').addClass("has-error");
		}
	});
}

ChatApp.WebSocket = {};
ChatApp.WebSocket.init_events = function(){
  var data = {};
  data.user_id = current_user.id;
  data = $.param(data);
	ChatApp.WebSocket.socket = new WebSocket("ws://" + window.location.host + "/chat?"+ data);

  ChatApp.WebSocket.socket.onopen = function(event) {
  };
  ChatApp.WebSocket.socket.onerror = function(event) {
  	ChatApp.disable("");
  	Amura.global_error_handler("");
  };
  ChatApp.WebSocket.socket.onclose = function(event) {
    var code = event.code;
    var reason = event.reason;
    var wasClean = event.wasClean;
    console.log("onclose : ", code, reason, wasClean)
  };
  ChatApp.WebSocket.socket.onmessage = function(e) {
    if (e.data.length) {
      var data = JSON.parse(e.data);
      ChatApp.on_new_message(data);
    }
  };
}
ChatApp.WebSocket.send_message = function($chatbox, sender_id, recipient_id, message){
  var data = {sender_id: sender_id,recipient_id: recipient_id, message: message};

  var packet = JSON.stringify(data, null, 2);
  ChatApp.WebSocket.socket.send(packet);

	var $panelbody = $chatbox.find(".panel-body")
	$chatbox.find('.message-input').val("").trigger("input");
	$panelbody.scrollTop($panelbody[0].scrollHeight);
}
ChatApp.formatMessage = function(message){
  return Autolinker.link(message);
}

$(document).on('page:change', function() {
	if(!_.isEmpty(window.current_user)){
		ChatApp.init();
	}
});

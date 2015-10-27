PublicChatApp = {};
PublicChatApp.socket = new WebSocket("ws://" + window.location.host + "/public_chat");

// http://www.emoji-cheat-sheet.com/
// twemoji.parse('I \u2764\uFE0F emoji!');
// var hash = CryptoJS.MD5("Message");

PublicChatApp.Init = function(name){
  PublicChatApp.socket.onmessage = function(e) {
    if (e.data.length) {
      var data = JSON.parse(e.data);

      if(data.name == current_user.user_name){
        data.name = "me";
      }
      console.log("received : ", data);
      PublicChatApp.sendNotification(data.name, data.message);
      $("#chat-window").append("@"+data.name + " - " + data.message + "<br>");
      $("#chat-window").animate({scrollTop: $("#chat-window").height()+1000}, 10)
    }
  };

  $("body").on("submit", "form.chat", function(e) {
    e.preventDefault();
    var $msg_text = $("#msg-text");
    var message = $msg_text.val();

    PublicChatApp.SendMessage(message);
    $msg_text.val(null);
  });

  PublicChatApp.InitEmojis();

  window.isActive = true;
  $(window).focus(function() { this.isActive = true; });
  $(window).blur(function() { this.isActive = false; });

  // request permission on page load
  if (Notification.permission !== "granted")
    Notification.requestPermission();

}

PublicChatApp.getName = function(){
  return current_user.user_name;
}
PublicChatApp.SendMessage = function(message){
    var name = PublicChatApp.getName();
    var data = {name: name, message: message};
    var packet = JSON.stringify(data, null, 2);

    console.log("sent : ", data);

    PublicChatApp.socket.send(packet);
    $("#chat-window").animate({scrollTop: $("#chat-window").height()+1000}, 10)
}

PublicChatApp.InitEmojis = function(){
  var $msg_text = $("#msg-text");
  $("#emoji-list .emoji_wrapper .emoji").click(function(e){
    var $target = $(this);
    var emoji_name = $target.attr("title");
    PublicChatApp.SendMessage(emoji_name);
  });
}

PublicChatApp.sendNotification = function(user_name, message){
  if (!Notification) {
    console.log('Desktop notifications not available in your browser. Switch to chrome ! :D');
    return;
  }

  if (!window.isActive && Notification.permission == "granted"){
    var notification_body = "@" + user_name + " - " + message;
    var notification = new Notification('AmuraBuzz Chat', {
      icon: 'http://amuratech.com/images/amura.png',
      body: notification_body,
    });

    notification.onclick = function () {
      window.focus();
    };
  }
}

$(function() {
  $("#msg-text").focus();

  var name = PublicChatApp.getName();

  PublicChatApp.Init(name);
});
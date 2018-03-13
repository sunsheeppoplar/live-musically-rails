//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

console.log("conversations.js invoked")

App.messages = App.cable.subscriptions.create("ConversationsChannel", {

  received: function(data) {
    console.log("i got it");
    // console.log(data);
    $.ajax({
      method: "GET",
      url: "/conversations/load_new_message",
      data: {
          "conversationId": data.conversation_id
      },
      dataType: "json"
    })
    .done(function(response) {
      console.log(response);

      // this is where the notification vs. append logic should go

      if (response.current_conversation == current_conversation) {
        $('.the-message').append(response.loaded_message);
        $('.the-message')[0].scrollTop = $('.the-message')[0].scrollHeight;
      }

    })
  },

  renderMessage: function(data) {
    console.log(data);
    // return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
  }

});
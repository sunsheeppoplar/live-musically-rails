//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

console.log("conversations.js invoked")

App.messages = App.cable.subscriptions.create("ConversationsChannel", {  
  received: function(data) {
    $("#messages").removeClass('hidden')
    return $('#messages').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    console.log(data);
    return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
  }
});
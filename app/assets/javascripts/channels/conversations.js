//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

console.log("conversations.js invoked")

App.messages = App.cable.subscriptions.create("ConversationsChannel", {

  received: function(data) {
    document.body.append(data.user + " sez: " + data.message);
  },

  renderMessage: function(data) {
    console.log(data);
    return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
  }

});
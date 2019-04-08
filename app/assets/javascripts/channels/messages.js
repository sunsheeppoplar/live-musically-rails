// console.log("messages.js invoked")

// App.messages = App.cable.subscriptions.create('MessagesChannel', {  
//   received: function(data) {
//     $("#messages").removeClass('hidden')
//     return $('#messages').append(this.renderMessage(data));
//   },

//   renderMessage: function(data) {
//     console.log(data);
//     return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
//   }
// });
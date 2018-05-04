// global variable baby
var current_conversation;

function highlightSelected(div) {
  $('.item').css(
    {
      "background":"#fcfcfc"
    }
  );
  
  $(div).css(
    {
      "background":"darkgrey"
    }
  );
}

$(document).on('turbolinks:load', function() {
  console.log('conversations.js (2) loaded');

  // sidebar listeners for conversations#load_conversation
  
  $('.item').click( function() {
    highlightSelected(this);
    $.ajax({
      method: "GET",
      url: "/conversations/load_conversation",
      data: {
          "conversationId": $(this).first().children('.conversationId')[0].textContent
      },
      dataType: "json"
    })
    .done(function(response) {
      // console.log(response);

      current_conversation = response.current_conversation;

      $('.the-message').empty();
      $('.the-message').append(response.loaded_convo);
      $('.the-message')[0].scrollTop = $('.the-message')[0].scrollHeight;
    })
  });

  // listener on send message button for messages#ajax_create behavior

  $('#send-message').click( function() {
    message_body = $('#message-body').val();
    $('#message-body').val("");

    $.ajax({
      method: "GET",
      url: "/conversations/send_message",
      data: {
          "conversation_id": current_conversation,
          "message": { 
            "body": message_body,
            "user_id": ""
          }
      },
      dataType: "json"
    })
  })
  
})
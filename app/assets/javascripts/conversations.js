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

  // sidebar listeners for search function

  $('#search').keyup(function() {

    var filter = $(this).val();
    // if (!filter) {
    //   $('.item-user-name').hide();
    //   return;
    // }

    var regex = new RegExp(filter, "i");


    $('.item-user-name').each(function() {
      if ($(this).text().search(regex) < 0) {
        $(this).parent().parent().fadeOut();
      } else {
        $(this).parent().parent().fadeIn();
        // count++;
      }
    });

  });

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
      $('.the-message').prepend($("<div class=individual-message id=load-previous>load previous messages</div>"));
      $('.the-message').append(response.loaded_convo);
      $('.the-message')[0].scrollTop = $('.the-message')[0].scrollHeight;

      $('#load-previous').click( function() {
        $.ajax({
          method: "GET",
          url: "/conversations/load_full_conversation",
          data: {
              "conversationId": current_conversation
          },
          dataType: "json"
        })
        .done(function(response) {
          $('.the-message').empty();
          $('.the-message').append(response.loaded_convo);
        })
      });
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
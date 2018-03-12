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
      $('.the-message').empty();
      $('.the-message').append(response.loaded_convo);
    })
  });
  
})
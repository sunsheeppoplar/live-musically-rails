$(document).on('turbolinks:load', function() {
	$('.js-apply-opp-form__open-modal-button')
		.on('ajax:success', function(e, data, status, xhr) {
			$('body').prepend(data.new_application)
		})
		.on('ajax:error', function(e, xhr, status, error) {
			var redirectURL = xhr.responseJSON.location;
			var flashType = xhr.responseJSON.hasOwnProperty('notice') ? 'notice' : 'alert';

			var flashMessage = "<span><a href='" + redirectURL + "'>" + xhr.responseJSON[flashType] +  "</a></span>"

			var flashClass = "." + flashType;
			$(flashClass).html(flashMessage);
		})
})
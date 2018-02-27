$(document).on('turbolinks:load', function() {
	$('.js-apply-opp-form__open-modal-button').on('ajax:success', function(e, data, status, xhr) {
		$('body').append(data.new_application)
	}) 
})
$(document).on('turbolinks:load', function() {
	$('#new_my_profile_form').on("ajax:success", function(e, data, status, xhr) {
		console.log('event', e)

		console.log('data', data)
		console.log('status', status)
		// $("#new_article").append xhr.responseText
	}).on("ajax:error", function(e, xhr, status, error) {
		// $("#new_article").append "<p>ERROR</p>"
	})

	$('.js-my-profile-textarea-edit-icon').on('click', function() {
		toggleTextAreaControls();
	})

	function toggleTextAreaControls() {
		$('.js-my-profile-textarea').prop('disabled', function(index, value) {
			return !value;
		})

		iconClass = 'my-profile-form__textarea-edit-submit';
		$('.js-my-profile-textarea-edit-submit').toggleClass(iconClass)
	}
	function listenForSubmit() {
		$('.js-my-profile-textarea-edit-submit').on('click', ajaxSubmitTextAreaInfo)
	}

	function ajaxSubmitTextAreaInfo() {
		$('#new_my_profile_form').submit();
	}

	listenForSubmit();
})

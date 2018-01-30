$(document).on('turbolinks:load', function() {
	$('#new_my_profile_form').on("ajax:success", function(e, data, status, xhr) {
		console.log('event', e)

		console.log('data', data)
		console.log('status', status)
		// $("#new_article").append xhr.responseText
	}).on("ajax:error", function(e, xhr, status, error) {
		// $("#new_article").append "<p>ERROR</p>"
	})


	function toggleInputControls(targetElement, submitButton, visibilityClass) {
		$(targetElement).prop('disabled', function(index, value) {
			return !value;
		})
		console.log(submitButton)
		console.log(visibilityClass)
		$(submitButton).toggleClass(visibilityClass);
	}
	function listenForSubmit(submitButtonClass, formPostedClass) {
		function ajaxSubmitUserInfo() {
			$(formPostedClass).submit();
		}
		$(submitButtonClass).on('click', ajaxSubmitUserInfo);
	}

	function togglePasswordInputsVisibility() {
		var targetClass = '.js-my-profile--password';
		var passwordInputsVisibilityClass = 'my-profile-form__password-fields';

		$(targetClass).toggleClass(passwordInputsVisibilityClass);
	}

	// assign event handlers
	listenForSubmit('.js-my-profile-textarea-edit-submit', '.js-my-profile--basic');
	listenForSubmit('.js-my-profile-inputs-edit-submit', '.js-my-profile--basic');
	listenForSubmit('.js-my-profile-user-info-edit-submit', '.js-my-profile--password')

	$('.js-my-profile-textarea-edit-icon').on('click', function() {
		var textareaClass = '.js-my-profile-textarea';
		var textareaSubmit = '.js-my-profile-textarea-edit-submit';
		var textareaSubmitVisibilityClass = 'my-profile-form__textarea-edit-submit';

		toggleInputControls(textareaClass, textareaSubmit, textareaSubmitVisibilityClass);
	})

	$('.js-my-profile-inputs-edit-icon').on('click', function() {
		var inputClass = '.js-my-profile-user-info-input-group';
		var inputSubmit = '.js-my-profile-inputs-edit-submit';
		var inputSubmitVisibilityClass = 'my-profile-form__input-group-edit-submit';

		toggleInputControls(inputClass, inputSubmit, inputSubmitVisibilityClass);
		togglePasswordInputsVisibility();
	})

	$('.js-my-profile-user-password-edit-icon').on('click', function() {
		var inputGroupClass = '.js-my-profile-user-password-input-group';
		var inputSubmit = '.js-my-profile-user-password-edit-submit';
		var inputSubmitVisibilityClass = 'my-profile-form__password-edit-submit';

		toggleInputControls(inputGroupClass, inputSubmit, inputSubmitVisibilityClass);

	})

})

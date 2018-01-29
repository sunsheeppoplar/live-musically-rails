$(document).on('turbolinks:load', function() {
	var formClass = '.js-new-opp-form';

	$('.js-new-opp-form-timeframe-checkbox').on('change', function() {
		$('.js-new-opp-form-timeframe-checkbox').not(this).prop('checked', false);
	})

	$('.js-new-opp-form-venue-checkbox').on('change', function() {
		$('.js-new-opp-form-venue-checkbox').not(this).prop('checked', false);
	})

	$(formClass).on("ajax:success", function(e, data) {

	}).on("ajax:error", function(e, data, status, error) {
		var errorResponse = data.responseJSON;
		handleErrors(errorResponse);
	})

	function handleErrors(errorObject) {
		Object.keys(errorObject.errors).forEach(function(key) {
			highlightBlankSections(key);
		})

		flashErrorMessages(errorObject.full_messages);
	}

	function flashErrorMessages(messages) {
		errorContainerClass = '.alert';

		var formattedMessages = messages.map(function(message) {
			var spanStart = '<span>';
			var spanEnd = '</span>';
			return spanStart + message + spanEnd;
		})
		$(errorContainerClass).html(formattedMessages);
	}

	function highlightBlankSections(inputName) {
		$(formClass).find('input, textarea').each(function() {
			name = $(this).attr('name')
			console.log(name)
			var parentSection;

			function findParentSection(name, el) {
				if (name.includes(inputName)) {
					parentSection = el.closest('section')
					return true
				}
			}

			function addErrorStyling() {
				$(parentSection).css("border-color", "red");
			}

			if (findParentSection(name, this)) {
				addErrorStyling();
				return false
			}
		})
	}
});


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
		Object.keys(data.responseJSON).forEach(function(key) {
			showErrors(key)
		})
	})

	function showErrors(inputName) {
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


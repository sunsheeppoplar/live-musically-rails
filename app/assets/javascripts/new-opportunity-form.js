$(document).on('turbolinks:load', function() {
	$('.js-new-opp-form-timeframe-checkbox').on('change', function() {
		$('.js-new-opp-form-timeframe-checkbox').not(this).prop('checked', false);
	})

	$('.js-new-opp-form-venue-checkbox').on('change', function() {
		$('.js-new-opp-form-venue-checkbox').not(this).prop('checked', false);
	})
});
$(document).on('turbolinks:load', function() {
	function instantiateDatePickers() {
		$('.input-daterange').each(function() {
			$(this).datepicker({
				todayHighlight: true,
				startDate: new Date()
			})
		})
	}

	function setInitialDateValues() {
		var initialStartDate = $('#newOppStartDate').val();
		var initialEndDate = $('#newOppEndDate').val();

		$('#employer_opportunity_form_event_start_date').val(initialStartDate);
		$('#employer_opportunity_form_event_end_date').val(initialEndDate);
	}

	$('#newOppStartDate').on('changeDate', function(event) {
		$('#employer_opportunity_form_event_start_date').val(event.date);
	})

	$('#newOppEndDate').on('changeDate', function(event) {
		$('#employer_opportunity_form_event_end_date').val(event.date);
	})


	instantiateDatePickers();
	setInitialDateValues();
});

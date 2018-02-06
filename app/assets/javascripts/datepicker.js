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

		var rubyStartDateString = switchMonthAndDate(initialStartDate);
		var rubyEndDateString = switchMonthAndDate(initialEndDate);

		$('#employer_opportunity_form_event_start_date').val(rubyStartDateString);
		$('#employer_opportunity_form_event_end_date').val(rubyEndDateString);
	}

	function switchMonthAndDate(dateString) {
		var splitDateStringArray = dateString.split('/');
		var month = splitDateStringArray[0];
		var day = splitDateStringArray[1];
		var year = splitDateStringArray[2];

		return day + '/' + month + '/' + year;
	}

	function formatDateStringForRuby(date) {
		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();

		return day + '/' + month + '/' + year;
	}

	$('#newOppStartDate').on('changeDate', function(event) {
		var rubyDateString = formatDateStringForRuby(event.date)

		$('#employer_opportunity_form_event_start_date').val(rubyDateString);
	})

	$('#newOppEndDate').on('changeDate', function(event) {
		var rubyDateString = formatDateStringForRuby(event.date);

		$('#employer_opportunity_form_event_end_date').val(rubyDateString);
	})


	instantiateDatePickers();
	setInitialDateValues();
});

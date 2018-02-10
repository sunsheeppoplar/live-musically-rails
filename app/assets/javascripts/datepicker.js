$(document).on('turbolinks:load', function() {
	function instantiateDatePickers() {
		if (this.page.controller() == 'opportunities' && this.page.action() == 'edit') {

			var initialStartDate = $('#employer_opportunity_form_event_start_date').val();
			var initialEndDate = $('#employer_opportunity_form_event_end_date').val();

			var datesWithoutUTCStamp = produceRubyStringsArray([initialStartDate, initialEndDate])

			$('.input-daterange input').each(function(index) {
				$(this).datepicker('setDate', datesWithoutUTCStamp[index])
			})
		}

		if (this.page.controller() == 'opportunities' && this.page.action() == 'new') {
			$('.input-daterange').each(function() {
				$(this).datepicker({
					todayHighlight: true,
					startDate: new Date()
				})
			})
			setInitialDateValues();
		}
	}

	function produceRubyStringsArray(datesArray) {
		var returnArray = [];
		datesArray.forEach(function(e) {
			var temp = e.split(' ')[0].split('-');
			var year = temp[0]
			var month = temp[1]
			var day = temp[2]
			var rearrangedDateString = month + '/' + day + '/' + year;
			returnArray.push(new Date(rearrangedDateString))
		})
		return returnArray;
	}

	function setInitialDateValues() {
		var startElementClass = '#newOppStartDate';
		var endElementClass = '#newOppEndDate';

		var initialStartDate = $(startElementClass).val();
		var initialEndDate = $(endElementClass).val();

		var rubyStartDateString = formatDateStringForRuby(new Date(initialStartDate));
		var rubyEndDateString = formatDateStringForRuby(new Date(initialEndDate));

		$('#employer_opportunity_form_event_start_date').val(rubyStartDateString);
		$('#employer_opportunity_form_event_end_date').val(rubyEndDateString);
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
});

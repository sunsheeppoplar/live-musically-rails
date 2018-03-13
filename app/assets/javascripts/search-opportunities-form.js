$(document).on('turbolinks:load', function() {
	$('#search_opportunities_instruments').autocomplete({
			select: function(event, ui) {
				selectInstrument(ui)
		 	},
		    source: $('#search_opportunities_instruments').data('autocomplete-source')
	 });

	$('#search_opportunities_locations').autocomplete({
			select: function(event, ui) {
				selectInstrument(ui)
		 	},
		    source: $('#search_opportunities_locations').data('autocomplete-source')
	 });

	function instantiateDatePickers() {
		$('.input-daterange').each(function() {
			$(this).datepicker({
				todayHighlight: true,
				startDate: new Date()
			})
		})
	}

	function instantiateTimePickers() {
		var startTimeTarget, endTimeTarget, defaultStartTime, defaultEndTime;

		$('#searchOppStartTime').timepicker({
			minuteStep: 15,
			icons: {
				up: 'glyphicon glyphicon-chevron-up',
				down: 'glyphicon glyphicon-chevron-down'
			}
		});
		$('#searchOppEndTime').timepicker({
			minuteStep: 15,
			icons: {
				up: 'glyphicon glyphicon-chevron-up',
				down: 'glyphicon glyphicon-chevron-down'
			}
		});
	}

	function setInitialDateValues() {
		var startElementClass = '#searchOppStartDate';
		var endElementClass = '#searchOppEndDate';

		var initialStartDate = $(startElementClass).val();
		var initialEndDate = $(endElementClass).val();

		var rubyStartDateString = formatDateStringForRuby(new Date(initialStartDate));
		var rubyEndDateString = formatDateStringForRuby(new Date(initialEndDate));

		$('#opportunities_search_form_event_start_date').val(rubyStartDateString);
		$('#opportunities_search_form_event_end_date').val(rubyEndDateString);
	}

	function setInitialTimeValues() {
		var initialStartTime = $('#searchOppStartTime').val();
		var initialEndTime = $('#searchOppEndTime').val();

		$('#opportunities_search_form_event_start_time').val(initialStartTime);
		$('#opportunities_search_form_event_end_time').val(initialEndTime);
	}

	function assignTimepickerListeners() {
		$('#searchOppStartTime').on('changeTime.timepicker', function(event) {
			$('#opportunities_search_form_event_start_time').val(event.time.value);
		});

		$('#searchOppEndTime').on('changeTime.timepicker', function(event) {
			$('#opportunities_search_form_event_end_time').val(event.time.value);    
		});
	}

	function assignDatepickerListeners() {
		$('#searchOppStartDate').on('changeDate', function(event) {
			var rubyDateString = formatDateStringForRuby(event.date)
			$('#opportunities_search_form_event_start_date').val(rubyDateString);
		})

		$('#searchOppEndDate').on('changeDate', function(event) {
			var rubyDateString = formatDateStringForRuby(event.date);

			$('#opportunities_search_form_event_end_date').val(rubyDateString);
		})
	}

	function formatDateStringForRuby(date) {
		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();

		return day + '/' + month + '/' + year;
	}

	(function calendarSetup() {
		assignTimepickerListeners();
		assignDatepickerListeners();
		instantiateDatePickers();
		instantiateTimePickers();
		setInitialDateValues();
		setInitialTimeValues();
	})()
})
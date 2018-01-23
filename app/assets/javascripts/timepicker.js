$(document).on('turbolinks:load', function() {
	function instantiateTimePickers() {
		$('#newOppStartTime').timepicker({
			minuteStep: 15,
			icons: {
				up: 'glyphicon glyphicon-chevron-up',
				down: 'glyphicon glyphicon-chevron-down'
			}
		});
		$('#newOppEndTime').timepicker({
			minuteStep: 15,
			icons: {
				up: 'glyphicon glyphicon-chevron-up',
				down: 'glyphicon glyphicon-chevron-down'
			}
		});
	}

	function setInitialTimeValues() {
		var initialStartTime = $('#newOppStartTime').val();
		var initialEndTime = $('#newOppEndTime').val();

		$('#employer_opportunity_form_event_start_time').val(initialStartTime);
		$('#employer_opportunity_form_event_end_time').val(initialEndTime);
	}

	$('#newOppStartTime').on('changeTime.timepicker', function(event) {
		$('#employer_opportunity_form_event_start_time').val(event.time.value);
	});

	$('#newOppEndTime').on('changeTime.timepicker', function(event) {
		$('#employer_opportunity_form_event_end_time').val(event.time.value);    
	});

	instantiateTimePickers();
	setInitialTimeValues();
})
$(document).on('turbolinks:load', function() {
	function instantiateTimePickers() {
		var startTimeTarget, endTimeTarget, defaultStartTime, defaultEndTime;

		if (this.page.controller()== 'opportunities' && this.page.action() == 'edit') {
			startTimeTarget = '#employer_opportunity_form_event_start_time';
			endTimeTarget = '#employer_opportunity_form_event_end_time';

			defaultStartTime = $(startTimeTarget).val();
			defaultEndTime = $(endTimeTarget).val();
		} else {
			defaultStartTime = 'current';
			defaultEndTime = 'current';
		}


		$('#newOppStartTime').timepicker({
			defaultTime: defaultStartTime,
			minuteStep: 15,
			icons: {
				up: 'glyphicon glyphicon-chevron-up',
				down: 'glyphicon glyphicon-chevron-down'
			}
		});
		$('#newOppEndTime').timepicker({
			defaultTime: defaultEndTime,
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
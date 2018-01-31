$(document).on('turbolinks:load', function() {


	$('#my_profile_form_instruments').autocomplete({
		select: function(event, ui) {
			selectInstrument(ui)
	 	},
	    source: $('#my_profile_form_instruments').data('autocomplete-source')
	});

	function selectInstrument(instrument) {
		$("#box").html(instrument.item.value);
	}
})
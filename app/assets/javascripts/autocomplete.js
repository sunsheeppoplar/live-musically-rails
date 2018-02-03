$(document).on('turbolinks:load', function() {
    String.prototype.escapeSelector = function () {
        return this.replace(
            /([$%&()*+,./:;<=>?@\[\\\]^\{|}~])/g,
            '\\$1'
        );
    };

    hideInstrumentInputs();

	$('#my_profile_form_instruments').autocomplete({
		select: function(event, ui) {
			selectInstrument(ui)
	 	},
	    source: $('#my_profile_form_instruments').data('autocomplete-source')
	});

	function selectInstrument(instrument) {
        if ($('.js-instrument-list-node').text().includes(instrument.item.value)) {
            return;
        }
        $('#js-instrument-container').append(
            $('<div/>')
                .addClass('js-instrument-list-node')
                .text(instrument.item.value)
                .append(
                    $('<div style="display:inline"> (x)</div>')
                        .addClass('x-button')
                        .click( function() {
                            $(this)
                            .closest('.js-instrument-list-node')
                            .remove();
                            unselectHiddenInstrument(instrument.item.value);
                        })
                )
        );
        selectHiddenInstrument(instrument.item.value);
    }

    function hideInstrumentInputs() {
        // $(".my-profile-form__checkbox, .my-profile-form__label").css({ display: "none" })
    }

    function selectHiddenInstrument(instrumentName) {
        instrumentName = instrumentName.escapeSelector().split(" ").join("\\ ")
        $("#instruments_"+instrumentName).prop("checked", true);
    }

    function unselectHiddenInstrument(instrumentName) {
        instrumentName = instrumentName.escapeSelector().split(" ").join("\\ ")
        $("#instruments_"+instrumentName).prop("checked", false);
    }

    function submitSelectedInstruments() {

    }
})
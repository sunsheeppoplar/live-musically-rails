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

    $('#my_profile_form_locations').on('keydown', function(e) {
        if (e.key == "Enter") {
            e.preventDefault();
            queryForZipcode( 
                $('#my_profile_form_locations').val() 
            );
            $('#my_profile_form_locations').val("");
        }
    });

    function queryForZipcode(zipcode) {
        $.ajax({
            method: "GET",
            url: "/my_profile/get_single_zipcode",
            data: { zipcode: zipcode },
            dataType: "json"
        })
        .done(function(response) {
            if (response.location.length > 0) {
                appendLocation(response.location[0]);
            }
            else {
                console.log("zip not found");
            }
        });
    }

    function appendLocation(loc_obj) {
        $('#js-location-container').append(
            $('<div/>')
                .addClass('js-location-list-node')
                .text(loc_obj.city + " - " + loc_obj.state)
                .append(
                    $('<div style="display:inline"> (x)</div>')
                        .addClass('x-button')
                        .click( function() {
                            $(this)
                            .closest('.js-location-list-node')
                            .remove();
                        })
                )
        );
    }

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
        $('.my-profile-form__checkbox-input-group').css({display:"none"});
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
function queryForZipcode(zipcode) {
    console.log("how does this work");
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
    var id = appendHiddenNode("locations", loc_obj.zipcode);
    $('#js-location-container').append(
        $('<div/>')
            .addClass('js-location-list-node')
            .text(loc_obj.zipcode + " - " + loc_obj.city + ", " + loc_obj.state)
            .append(
                $('<span>')
                    .addClass('glyphicon glyphicon-remove')
                    .click( function() {
                        $(this)
                        .closest('.js-location-list-node')
                        .remove();
                        $('#' + id).remove();
                        console.log(id);
                    })
            )
    );
}

function selectInstrument(instrument) {
    if ($('.js-instrument-list-node').text().includes(instrument.item.value)) {
        return;
    }
    appendInstrument(instrument.item.value);
}

function appendInstrument(instrument) {
    var id = appendHiddenNode("instruments", instrument);
    $('#js-instrument-container').append(
        $('<div/>')
            .addClass('js-instrument-list-node')
            .text(instrument)
            .append(
                $('<span>')
                    .addClass('glyphicon glyphicon-remove')
                    .click( function() {
                        $(this)
                        .closest('.js-instrument-list-node')
                        .remove();
                        $('#' + id).remove();
                        // unselectHiddenInstrument(instrument);
                    })
            )
    );
    // selectHiddenInstrument(instrument);
}

// function hideInstrumentInputs() {
//     $('.my-profile-form__checkbox-input-group').css({display:"none"});
// }

// function selectHiddenInstrument(instrumentName) {
//     instrumentName = instrumentName.escapeSelector().split(" ").join("\\ ")
//     $("#instruments_"+instrumentName).prop("checked", true);
// }

// function unselectHiddenInstrument(instrumentName) {
//     instrumentName = instrumentName.escapeSelector().split(" ").join("\\ ")
//     $("#instruments_"+instrumentName).prop("checked", false);
// }
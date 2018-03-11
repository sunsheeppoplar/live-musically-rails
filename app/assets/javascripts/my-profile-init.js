$(document).on('turbolinks:load', function() {
    String.prototype.escapeSelector = function () {
        return this.replace(
            /([$%&()*+,./:;<=>?@\[\\\]^\{|}~])/g,
            '\\$1'
        );
    };

	$('#my_profile_form_instruments').autocomplete({
		select: function(event, ui) {
			selectInstrument(ui)
	 	},
	    source: $('#my_profile_form_instruments').data('autocomplete-source')
    });

    $('#js-instrument-container').children()
    .append(
        $('<span>')
            .addClass('glyphicon glyphicon-remove')
            .click( function() {
                $(this)
                .closest('.js-instrument-list-node')
                .remove();
                $('#' + md5(this.parentNode.firstChild.textContent)).remove();
                // unselectHiddenInstrument(this.parentNode.firstChild.textContent);
            })
    );

    $('#js-location-container').children()
    .append(
        $('<span>')
            .addClass('glyphicon glyphicon-remove')
            .click( function() {
                $(this)
                .closest('.js-location-list-node')
                .remove();
                $('#' + md5(this.parentNode.firstChild.textContent.split(" ")[0])).remove();
            })
    );

    $('#js-soundcloud-container').children()
    .append(
        $('<span>')
            .addClass('glyphicon glyphicon-remove')
            .click( function() {
                $(this)
                .closest('.js-soundcloud-list-node')
                .remove();
                $('#' + md5(this.parentNode.firstChild.textContent)).remove();
                var text = this.parentNode.firstChild.textContent;
                // var track_id = text.split("/")[text.split("/").length-1];
                destroyEmbeddedSoundcloudFrame(md5(this.parentNode.firstChild.textContent));
            })
    );

    $('#js-youtube-container').children()
    .append(
        $('<span>')
            .addClass('glyphicon glyphicon-remove')
            .click( function() {
                $(this)
                .closest('.js-youtube-list-node')
                .remove();
                $('#' + md5(this.parentNode.firstChild.textContent)).remove();
                var text = this.parentNode.firstChild.textContent;
                destroyEmbeddedYoutubeFrame(md5(this.parentNode.firstChild.textContent));
            })
    );
    
    $('#my_profile_form_locations').on('keydown', function(e) {
        if (e.keyCode == 13) {
            e.preventDefault();
            queryForZipcode($('#my_profile_form_locations').val());
            $('#my_profile_form_locations').val("");
        }
    });

    $('#my_profile_form_instruments').on('keydown', function(e) {
        if (e.keyCode == 13) {
            e.preventDefault();
        }
    });

    $('#my_profile_form_soundcloud').on('keydown', function(e) {
        if (e.keyCode == 13) {
            e.preventDefault();
            var scVideoId = checkSoundcloudLinkFormat($('#my_profile_form_soundcloud').val());
            if ( scVideoId != null && !isDuplicate("js-soundcloud-list-node", $('#my_profile_form_soundcloud').val()) ) {
                appendSoundcloudLink($('#my_profile_form_soundcloud').val());
                appendEmbeddedSoundcloud(scVideoId, $('#my_profile_form_soundcloud').val());
            } else {
                console.log("you fukked up the soundcloud");
            }
            $('#my_profile_form_soundcloud').val("");
        }
    });

    $('#my_profile_form_youtube').on('keydown', function(e) {
        if (e.keyCode == 13) {
            e.preventDefault();
            var ytVideoId = checkYoutubeLinkFormat($('#my_profile_form_youtube').val());
            if ( ytVideoId != null && !isDuplicate("js-youtube-list-node", $('#my_profile_form_youtube').val()) ) {
                appendYoutubeLink($('#my_profile_form_youtube').val())
                appendEmbeddedYoutube(ytVideoId, $('#my_profile_form_youtube').val());
            } else {
                console.log("you fucked up");
            }
            $('#my_profile_form_youtube').val("")
        }
    });

})
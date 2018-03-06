// before this file gets renamed: look under my-profile-* for function declarations

$(document).on('turbolinks:load', function() {

    String.prototype.escapeSelector = function () {
        return this.replace(
            /([$%&()*+,./:;<=>?@\[\\\]^\{|}~])/g,
            '\\$1'
        );
    };

    if (page.controller() == 'profiles' && page.action() == 'my_profile') {
        $.ajax({
            cache: false,
            method: "GET",
            url: "/my_profile",
            dataType: "json"
        })
        .done(function(response) {
            response.instruments.forEach(function(instrument) {
                appendInstrument(instrument.name);
            });
            response.locations.forEach(function(location) {
                appendLocation(location);
            });
            response.ext_links.forEach(function(ext_link) {
                if (ext_link.origin_site == "sc") {
                    appendSoundcloudLink(ext_link.link_to_content);
                }
                else if (ext_link.origin_site == "yt") {
                    appendYoutubeLink(ext_link.link_to_content);
                }
            });
        });
    }

    $('#my_profile_form_locations').on('keydown', function(e) {
        if (e.keyCode == 13) {
            e.preventDefault();
            queryForZipcode( 
                $('#my_profile_form_locations').val() 
            );
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
            appendSoundcloudLink($('#my_profile_form_soundcloud').val());
            appendEmbeddedSoundcloud($('#my_profile_form_soundcloud').val());
            $('#my_profile_form_soundcloud').val("");
        }
    });

    $('#my_profile_form_youtube').on('keydown', function(e) {
        if (e.keyCode == 13) {
            e.preventDefault();
            appendYoutubeLink($('#my_profile_form_youtube').val());
            appendEmbeddedYoutube($('#my_profile_form_youtube').val());
            $('#my_profile_form_youtube').val("")
        }
    });

    $('#js-the-button').on('click', function() {
        var instruments = $('.js-instrument-list-node'),
            locations = $('.js-location-list-node'),
            sc_links = $('.js-soundcloud-list-node'),
            yt_links = $('.js-youtube-list-node');

        var plainInsArray = [],
            plainZipArray = [],
            scLinksArray = [],
            ytLinksArray = [];

        $.each(instruments, function(index, value) {
            plainInsArray[index] = instruments[index].firstChild.nodeValue;
        });
        $.each(locations, function(index, value) {
            plainZipArray[index] = locations[index].firstChild.nodeValue.split(" ")[0];
        });
        $.each(sc_links, function(index, value) {
            scLinksArray[index] = sc_links[index].firstChild.nodeValue;
        });
        $.each(yt_links, function(index, value) {
            ytLinksArray[index] = yt_links[index].firstChild.nodeValue;
        });

        $.ajax({
            method: "PATCH",
            url: "/my_profile",
            data: {
                "my_profile_form": {
                    "instruments": plainInsArray,
                    "locations": plainZipArray,
                    "soundcloud_links": scLinksArray,
                    "youtube_links": ytLinksArray
                }
            },
            dataType: "json"
        })
        .done(function(response) {
            console.log(response);
        });
    });

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
                // var video_id = text.split("v=")[1];
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
            if ( scVideoId != null ) {
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
            if ( ytVideoId != null ) {
                appendYoutubeLink($('#my_profile_form_youtube').val())
                appendEmbeddedYoutube(ytVideoId, $('#my_profile_form_youtube').val());
            } else {
                console.log("you fucked up");
            }
            $('#my_profile_form_youtube').val("")
        }
    });

})
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
        if (e.key == "Enter") {
            e.preventDefault();
            queryForZipcode( 
                $('#my_profile_form_locations').val() 
            );
            $('#my_profile_form_locations').val("");
        }
    });

    $('#my_profile_form_instruments').on('keydown', function(e) {
        if (e.key == "Enter") {
            e.preventDefault();
        }
    });

    $('#my_profile_form_soundcloud').on('keydown', function(e) {
        if (e.key == "Enter") {
            e.preventDefault();
            appendSoundcloudLink($('#my_profile_form_soundcloud').val());
            appendEmbeddedSoundcloud($('#my_profile_form_soundcloud').val());
            $('#my_profile_form_soundcloud').val("");
        }
    });

    $('#my_profile_form_youtube').on('keydown', function(e) {
        if (e.key == "Enter") {
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

        // console.log(plainInsArray);
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
                .text(loc_obj.zipcode + " - " + loc_obj.city + ", " + loc_obj.state)
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
        appendInstrument(instrument.item.value);
    }

    function appendInstrument(instrument) {
        $('#js-instrument-container').append(
            $('<div/>')
                .addClass('js-instrument-list-node')
                .text(instrument)
                .append(
                    $('<div style="display:inline"> (x)</div>')
                        .addClass('x-button')
                        .click( function() {
                            $(this)
                            .closest('.js-instrument-list-node')
                            .remove();
                            unselectHiddenInstrument(instrument);
                        })
                )
        );
        selectHiddenInstrument(instrument);
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

    function submitInstruments() {

    }

    function appendSoundcloudLink(link) {
        var track_id = link.split("/")[link.split("/").length-1];
        $('#js-soundcloud-container').append(
            $('<div/>')
                .addClass('js-soundcloud-list-node')
                    .text(link)
                    .append(
                        $('<div style="display:inline"> (x)</div>')
                                .addClass('x-button')
                                .click( function() {
                                    $(this)
                                        .closest('.js-soundcloud-list-node')
                                        .remove()
                                        console.log(track_id);
                                    destroyEmbeddedSoundcloudFrame(track_id);
                                })
                    )
        );
    }

    function appendYoutubeLink(link) {
        var video_id = link.split("v=")[1];
        $('#js-youtube-container').append(
            $('<div/>')
                .addClass('js-youtube-list-node')
                    .text(link)
                    .append(
                        $('<div style="display:inline"> (x)</div>')
                            .addClass('x-button')
                            .click( function() {
                                $(this)
                                    .closest('.js-youtube-list-node')
                                    .remove()
                                destroyEmbeddedYoutubeFrame(video_id);
                            })
                    )
        );
    }

    // very hacky atm

    function appendEmbeddedSoundcloud(link) {
        var track_id = link.split("/")[link.split("/").length];
        var player_url = "https://w.soundcloud.com/player/?url=";
        var player_options = "&show_artwork=false";
        
        constructed_link = player_url + link + player_options;

        
        $('<iframe>', {
            src: constructed_link,
            id:  track_id,
            margin: "50px",
            width: "50%",
            height: "100",
            frameborder: "no",
            scrolling: 'no'
            })
            .appendTo('#js-embedded-soundcloud-container');
    }

    function appendEmbeddedYoutube(link) {
        var video_id = link.split("v=")[1];
        var player_options = "?start=0",
        constructed_link = "https://www.youtube.com/embed/" + video_id + player_options;
        
        $('<iframe>', {
            src: constructed_link,
            id: video_id,
            width: "250",
            height: "140",
            allow: "encrypted-media",
            allowfullscreen: "",
            frameborder: 0,
            scrolling: 'no'
            })
            .appendTo('#js-embedded-youtube-container');
    }

    function destroyEmbeddedSoundcloudFrame(track_id) {
        var id = "#" + track_id;
        console.log(id);
        $(id).remove();
    }

    function destroyEmbeddedYoutubeFrame(video_id) {
        var id = "#" + video_id;
        $(id).remove();
    }

})
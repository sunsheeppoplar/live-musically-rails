function checkSoundcloudLinkFormat(link) {
    var track_id = "";

    if (link.match(/^(?<![\w\d])https:\/\/soundcloud.com(?![\w\d])/) != null  || link.match(/^(?<![\w\d])http:\/\/soundcloud.com(?![\w\d])/) != null) {
        track_id = link.split("/")[link.split("/").length-1];
    } else if (link.match(/^(?<![\w\d])https:\/\/www.soundcloud.com(?![\w\d])/) != null  || link.match(/^(?<![\w\d])http:\/\/www.soundcloud.com(?![\w\d])/) != null) {
        track_id = link.split("/")[link.split("/").length-1];
    } else {
        alert("PLACEHOLDER ERROR -> track url must be in one of these formats: \nhttps://soundcloud.com/xxx/yyy \nhttp://soundcloud.com/xxx/yyy");
        console.log("fucked up sc link");
        return null;
    }
    return track_id;
}

function checkYoutubeLinkFormat(link) {
    var video_id = "";

    if (link.match(/^(?<![\w\d])https:\/\/youtu.be(?![\w\d])/) != null  || link.match(/^(?<![\w\d])http:\/\/youtu.be(?![\w\d])/) != null) {
        video_id = link.split("/")[3];
    } else if (link.match(/^(?<![\w\d])https:\/\/youtube.com(?![\w\d])/) != null  || link.match(/^(?<![\w\d])http:\/\/youtube.com(?![\w\d])/) != null) {
        video_id = link.split("v=")[1];
    } else if (link.match(/^(?<![\w\d])https:\/\/www.youtube.com(?![\w\d])/) != null  || link.match(/^(?<![\w\d])http:\/\/www.youtube.com(?![\w\d])/) != null) {
        video_id = link.split("v=")[1];
    } else {
        console.log("fucked up yt link");
        alert("PLACEHOLDER ERROR -> video url must be in one of these formats: \nhttps://youtu.be/xxx \nhttp://youtu.be/xxx \nhttps://www.youtube.com/watch?v=xxx \nhttp://www.youtube.com/watch?v=xxx");
        return null;
    }
    return video_id;
}

function appendSoundcloudLink(link) {
    var id = appendHiddenNode("soundcloud_links", link);
    $('#js-soundcloud-container').append(
        $('<div/>')
            .addClass('js-soundcloud-list-node')
                .text(link)
                .append(
                    $('<span>')
                            .addClass('glyphicon glyphicon-remove')
                            .click( function() {
                                $(this)
                                    .closest('.js-soundcloud-list-node')
                                    .remove()
                                    $('#' + id).remove();
                                    console.log(id);
                                destroyEmbeddedSoundcloudFrame(id);
                            })
                )
    );
}

function appendYoutubeLink(link) {
    var id = appendHiddenNode("youtube_links", link);
    $('#js-youtube-container').append(
        $('<div/>')
            .addClass('js-youtube-list-node')
                .text(link)
                .append(
                    $('<span>')
                        .addClass('glyphicon glyphicon-remove')
                        .click( function() {
                            $(this)
                                .closest('.js-youtube-list-node')
                                .remove();
                            $('#' + id).remove();
                            destroyEmbeddedYoutubeFrame(id);
                        })
                )
    );
}

// very hacky atm

function appendEmbeddedSoundcloud(track_id, link) {
    var div_id = md5(link);
    
    var player_url = "https://w.soundcloud.com/player/?url=";
    var player_options = "&show_artwork=false";
    
    var constructed_link = player_url + link + player_options;

    
    $('<iframe>', {
        src: constructed_link,
        id:  div_id,
        margin: "50px",
        width: "50%",
        height: "100",
        frameborder: "no",
        scrolling: 'no'
        })
        .appendTo('#js-embedded-soundcloud-container');
}

function appendEmbeddedYoutube(video_id, link) {
    var div_id = md5(link);
    var player_options = "?start=0";

    var constructed_link = "https://www.youtube.com/embed/" + video_id + player_options;
    
    $('<iframe>', {
        src: constructed_link,
        id: div_id,
        width: "250",
        height: "140",
        allow: "encrypted-media",
        allowfullscreen: "",
        frameborder: 0,
        scrolling: 'no'
        })
        .appendTo('#js-embedded-youtube-container');
}

function destroyEmbeddedSoundcloudFrame(div_id) {
    var id = "#" + div_id;
    console.log(id);
    $(id).remove();
}

function destroyEmbeddedYoutubeFrame(div_id) {
    var id = "#" + div_id;
    $(id).remove();
}

function appendHiddenNode(formAttribute, value) {
    var name = "my_profile_form[" + formAttribute + "][]";
    var id = md5(value);
    $('.js-my-profile--basic').append(
        $('<input/>')
            .prop('name', name)
            .prop('value', value)
            .attr('id', id)
            .css({display: "none"})
    );
    return id;
}
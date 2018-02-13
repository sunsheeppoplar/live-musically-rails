class ArtistProfileService
    extend ActionView::Helpers::TagHelper

    def self.soundcloud_frame(track_url)
        track_id = track_url.split('/').last
        player_url = "https://w.soundcloud.com/player/?url="
        player_options = "&show_artwork=false"
        constructed_link = player_url + track_url + player_options
        content_tag(:iframe, '', :id => track_id, margin: "50px", width: "50%", height: "100", scrolling: "no", frameborder: "no", src: constructed_link)
    end

    def self.youtube_frame(video_url)
        player_options = "?start=0"
        video_id = video_url.split('v=').last
        constructed_link = "https://www.youtube.com/embed/" + video_id + player_options
        content_tag(:iframe, '', :id => video_id, width: "250", height: "140", frameborder: "no", allow: "encrypted-media", allowfullscreen: "", src: constructed_link)
    end

    def self.render_instrument(instrument)
        content_tag(:div, instrument.name, :class => "js-instrument-list-node")
    end

    def self.render_location(location)
        content_tag(:div, "#{location.zipcode} - #{location.city}, #{location.state}", :class => "js-location-list-node")
    end

    def self.render_soundcloud_link(link_to_content)
        content_tag(:div, link_to_content, :class => "js-soundcloud-list-node")
    end

    def self.render_youtube_link(link_to_content)
        content_tag(:div, link_to_content, :class => "js-youtube-list-node")
    end
    
end
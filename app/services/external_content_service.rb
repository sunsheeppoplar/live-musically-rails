class ExternalContentService
    extend ActionView::Helpers::TagHelper

    def self.soundcloud_frame(track_url)
        player_url = "https://w.soundcloud.com/player/?url="
        player_options = "&show_artwork=false"
        constructed_link = player_url + track_url + player_options
        content_tag(:iframe, '', margin: "50px", width: "50%", height: "100", scrolling: "no", frameborder: "no", src: constructed_link)
    end

    def self.youtube_frame(video_url)
        player_options = "?start=0"
        video_id = video_url.split('v=').last
        constructed_link = "https://www.youtube.com/embed/" + video_id + player_options
        content_tag(:iframe, '', width: "560", height: "315", frameborder: "no", allow: "encrypted-media", allowfullscreen: "", src: constructed_link)
    end
end
class ArtistProfileService
    extend ActionView::Helpers::TagHelper

    def self.soundcloud_frame(track_url)
        div_id = Digest::MD5.hexdigest(track_url)
        track_id = track_url.split('/').last
        player_url = "https://w.soundcloud.com/player/?url="
        player_options = "&show_artwork=false"
        constructed_link = player_url + track_url + player_options
        content_tag(:iframe, '', :id => div_id, margin: "50px", width: "50%", height: "100", scrolling: "no", frameborder: "no", src: constructed_link)
    end

    def self.youtube_frame(video_url)
        div_id = Digest::MD5.hexdigest(video_url)
        video_id = video_url.split('v=').last
        player_options = "?start=0"
        constructed_link = "https://www.youtube.com/embed/" + video_id + player_options
        content_tag(:iframe, '', :id => div_id, width: "250", height: "140", frameborder: "no", allow: "encrypted-media", allowfullscreen: "", src: constructed_link)
    end
    
end
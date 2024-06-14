# frozen_string_literal: true

class YouTubeEmbedComponent < ViewComponent::Base
  erb_template <<~ERB
    <iframe style="width: 100%; aspect-ratio: 16/9;" src="https://www.youtube.com/embed/<%= @video_id %>" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
  ERB

  def initialize(video_url:)
    # Users are expected to provide the YouTube video URL which needs converting to the embed URL
    @video_url = video_url

    @video_id = begin
      CGI.parse(URI.parse(@video_url).query)["v"].first
    rescue URI::InvalidURIError, NoMethodError
      nil
    end
  end

  def render?
    @video_id.present?
  end
end

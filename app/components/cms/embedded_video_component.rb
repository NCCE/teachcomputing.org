# frozen_string_literal: true

class Cms::EmbeddedVideoComponent < ViewComponent::Base
  def initialize(url:)
    @url = url
  end

  def render_video_format
    if @url.match?(/^https?:\/\/(www\.)?(youtube\.com|youtu\.be)/)
      render YouTubeEmbedComponent.new(video_url: @url)
    else
      video_tag(@url, controls: true)
    end
  end
end

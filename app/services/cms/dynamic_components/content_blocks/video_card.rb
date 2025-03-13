module Cms
  module DynamicComponents
    module ContentBlocks
      class VideoCard
        attr_accessor :video, :title, :name, :job_title, :text_content, :color_theme

        def initialize(video:, title:, name:, job_title:, text_content:, color_theme:)
          @video = video
          @title = title
          @name = name
          @job_title = job_title
          @text_content = text_content
          @color_theme = color_theme
        end

        def render
          Cms::VideoCardComponent.new(video:, title:, name:, job_title:, text_content:, color_theme:)
        end
      end
    end
  end
end

# frozen_string_literal: true

class Cms::VideoCardComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  def initialize(video:, title:, text_content:, name: nil, job_title: nil, color_theme: nil)
    @video = video
    @title = title
    @name = name
    @job_title = job_title
    @text_content = text_content
    @color_theme = color_theme
  end

  def wrapper_classes
    classes = ["cms-video-card-component white-bg"]
    classes << cms_color_theme_class(@color_theme, "top") if @color_theme
    classes
  end
end

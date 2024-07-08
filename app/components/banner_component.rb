# frozen_string_literal: true

class BannerComponent < ViewComponent::Base
  def initialize(title:, title_css: "govuk-heading-m", text: "", text_blocks: [], text_css: "govuk-body", padding: 3, link: nil, background_color: "white", box_color: nil, media_column_size: :third, image: nil, video: nil, video_type: :source, media_side: :left, wrapper_padding: nil, button: nil, title_link: nil)
    @title = title
    @title_css = title_css
    @text = text
    @text_blocks = text_blocks
    @text_css = text_css
    @padding = padding
    @image = image
    @video = video
    @video_type = video_type
    @background_color = background_color
    @box_color = box_color
    @media_column_size = media_column_size
    @media_side = media_side
    @link = link
    @wrapper_padding = wrapper_padding
    @button = button
    @title_link = title_link

    raise ArgumentError, "You must define a video or image resource" unless @image || @video
  end

  def govuk_wrapper_class
    "govuk-!-padding-#{@wrapper_padding}" if @wrapper_padding
  end

  def media_side_class
    if @media_side == :left
      "banner-component--media-left"
    else
      "banner-component--media-right"
    end
  end

  def media_column_class
    classes = ["banner-component__media-section"]
    classes << if @media_column_size == :third
      "banner-component__media-section--one-third"
    else
      "banner-component__media-section--half"
    end
    classes.join(" ")
  end

  def color_class(color)
    "#{color}-bg" if color
  end

  def text_column_class
    classes = ["banner-component__content-section"]
    classes << if @media_column_size == :third
      "banner-component__content-section--two-thirds"
    else
      "banner-component__content-section--half"
    end
    classes.join(" ")
  end
end

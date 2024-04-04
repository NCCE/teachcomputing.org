# frozen_string_literal: true

class BannerComponent < ViewComponent::Base
  def initialize(title:, text:, padding: 3, link: nil, background_color: "white", box_color: nil, media_column_size: :third, image: nil, video: nil, media_side: :left, wrapper_padding: nil)
    @title = title
    @text = text
    @padding = padding
    @image = image
    @video = video
    @background_color = background_color
    @box_color = box_color
    @media_column_size = media_column_size
    @media_side = media_side
    @link = link
    @wrapper_padding = wrapper_padding

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
    classes << case @media_column_size
    when :third
      "banner-component__media-section--one-third"
    when :half
      "banner-component__media-section--half"
    else
      "banner-component__media-section--one-third"
    end
    classes.join(" ")
  end

  def color_class color
    "#{color}-bg" if color
  end

  def text_column_class
    classes = ["banner-component__content-section"]
    classes << case @media_column_size
    when :third
      "banner-component__content-section--two-thirds"
    when :half
      "banner-component__content-section--half"
    else
      "banner-component__content-section--two-thirds"
    end
    classes.join(" ")
  end
end

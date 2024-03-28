# frozen_string_literal: true

class BannerComponent < ViewComponent::Base
  def initialize(title:, text:, padding: 3, link: nil, background_color: "white", media_column_size: :third, image: nil, video: nil, media_side: :left)
    @title = title
    @text = text
    @padding = padding
    @image = image
    @video = video
    @background_color = background_color
    @media_column_size = media_column_size
    @media_side = media_side
    @link = link
  end

  def media_column_class
    classes = ["banner-component banner-component__media-section"]
    classes << case @media_column_size
    when :third
      "govuk-grid-column-one-third"
    when :half
      "govuk-grid-column-one-half"
    else
      "govuk-grid-column-one-third"
    end
  end

  def text_column_class
    classes = ["banner-component banner-component__content-section"]
    classes << case @media_column_size
    when :third
      "govuk-grid-column-two-thirds"
    when :half
      "govuk-grid-column-one-half"
    else
      "govuk-grid-column-two-thirds"
    end
    classes.join(" ")
  end

  def media_block
    content_tag(:div, class: media_column_class) do
      image_pack_tag @image[:url], alt: @image[:alt] if @image
      if @video
        content_tag(:video, width: "100%", height: "auto", controls: :controls) do
          content_tag(:source, nil, src: @video[:url])
        end
      end
    end
  end
end

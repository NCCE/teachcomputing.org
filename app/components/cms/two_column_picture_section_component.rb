# frozen_string_literal: true

class Cms::TwoColumnPictureSectionComponent < ViewComponent::Base
  def initialize(text:, image:, image_side:, background_color:, banner:, section_title:)
    @text = text
    @image = image
    @image_side = image_side
    @background_color = background_color
    @banner = banner
    if @banner
      @banner.side = (@image_side == "right") ? "left" : "right"
    end
    @section_title = section_title
  end

  def image_align_classes
    classes = ["tc-row"]
    classes << "cms-two-column-picture-section-component--right-align" if @image_side == "right"
    classes
  end
end

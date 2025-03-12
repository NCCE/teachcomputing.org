# frozen_string_literal: true

class Cms::FullWidthImageBannerComponent < ViewComponent::Base
  delegate :cms_url, to: :helpers

  def initialize(background_image:, overlay_title:, overlay_text:, overlay_icon:, overlay_side:)
    @background_image = background_image
    @overlay_title = overlay_title
    @overlay_text = overlay_text
    @overlay_icon = overlay_icon
    @overlay_side = overlay_side
  end

  def show_overlay?
    !@overlay_text.nil? || !@overlay_title.nil?
  end

end

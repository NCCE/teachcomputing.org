# frozen_string_literal: true

class Cms::SiteWideBannerComponent < ViewComponent::Base
  def initialize(text_content:)
    @text_content = text_content
  end
end

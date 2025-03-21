# frozen_string_literal: true

class Cms::LinkComponent < ViewComponent::Base
  def initialize(url:, link_text:)
    @url = url
    @link_text = link_text
  end

  def call
    link_to(@link_text, @url)
  end
end

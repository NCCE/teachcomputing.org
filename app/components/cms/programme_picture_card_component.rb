# frozen_string_literal: true

class Cms::ProgrammePictureCardComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  def initialize(title:, text_content:, image:, card_links:, programme:)
    @title = title
    @text_content = text_content
    @image = image
    @card_links = card_links
    @programme = programme
  end

  def render?
    @programme.present?
  end
end

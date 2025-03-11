# frozen_string_literal: true

class Cms::IBelongPictureCardComponent < ViewComponent::Base
  delegate :current_user, to: :helpers

  def initialize(title:, text_content:, image:, card_links:)
    @title = title
    @text_content = text_content
    @image = image
    @card_links = card_links
    @programme = Programme.i_belong
  end

  def current_user_state
    return :logged_out unless current_user

    @programme.user_enrolled?(current_user) ? :enrolled : :not_enrolled
  end

  def card_link
    link = @card_links[current_user_state]

    link_to(link[:title], link[:link], class: "ncce-link")
  end
end

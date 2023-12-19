# frozen_string_literal: true

class ExternalLinkCardComponent < ViewComponent::Base
  def initialize(external_link_card:, title: nil, link: nil)
    @title = title ||= external_link_card[:title]
    @link = link || external_link_card[:link]
  end

  def render?
    @link.present?
  end
end

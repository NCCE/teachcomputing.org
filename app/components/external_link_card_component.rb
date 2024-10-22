# frozen_string_literal: true

class ExternalLinkCardComponent < ViewComponent::Base
  def initialize(external_link_card:, title: nil, link: nil, file_type: nil)
    @title = title || external_link_card[:title]
    @link = link || external_link_card[:link]
    @file_type = file_type || external_link_card[:file_type]
  end

  def render?
    @link.present?
  end
end

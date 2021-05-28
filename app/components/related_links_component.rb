# frozen_string_literal: true

class RelatedLinksComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(links: [], class_name: nil, image_url: nil)
    super
    @links = links.collect { |link| assign_links(link) }
    @class_name = class_name
    @image_url = image_url
  end

  def assign_links(link_title:, link_url:, tracking_page: nil, tracking_label: nil)
    { link_title: link_title, link_url: link_url, tracking_page: tracking_page, tracking_label: tracking_label }
  end
end

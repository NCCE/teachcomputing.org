# frozen_string_literal: true

class RelatedLinksComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(links: [], class_name: nil, image_url: nil)
    super
    @links = links
    @class_name = class_name
    @image_url = image_url
  end
end

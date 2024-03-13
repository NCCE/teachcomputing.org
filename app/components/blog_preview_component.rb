# frozen_string_literal: true

class BlogPreviewComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(title:, excerpt:, publish_date:, featured_image:, slug:)
    @title = title
    @excerpt = excerpt
    @publish_date = publish_date
    @featured_image = featured_image
    @slug = slug
  end
end

# frozen_string_literal: true

class BlogPreview < ViewComponent::Base
  def initialize(title:, excerpt:, publish_date:, featured_image:)
    @title = title
    @excerpt = excerpt
  end

  def call
    @title.to_s
  end
end

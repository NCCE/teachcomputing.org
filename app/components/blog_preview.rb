# frozen_string_literal: true

class BlogPreview < ViewComponent::Base
  def initialize(title:, excerpt:)
    @title = title
    @excerpt = excerpt
  end

  def call
    @title.to_s
  end
end

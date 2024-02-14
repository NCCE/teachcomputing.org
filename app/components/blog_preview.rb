# frozen_string_literal: true

class BlogPreview < ViewComponent::Base
  def initialize(title:)
    @title = title
  end

  def call
    @title.to_s
  end
end

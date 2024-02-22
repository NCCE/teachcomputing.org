# frozen_string_literal: true

class CmsHeroComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(resource, title:)
    @resource = resource
    @title = title
  end

  def call
    render HeroComponent.new(title: @title)
  end
end

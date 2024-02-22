# frozen_string_literal: true

class FeaturedImageComponent < ViewComponent::Base
  delegate :cms_image_url, to: :helpers

  def initialize(resource, params)
    @resource = resource
    @versions = params[:attributes][:formats]
    @alt_text = params[:attributes][:alternativeText]
    @caption = params[:attributes][:caption]
  end
end

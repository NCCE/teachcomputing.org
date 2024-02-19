# frozen_string_literal: true

class FeaturedImageComponent < ViewComponent::Base
  delegate :cms_image_url, to: :helpers

  def initialize(params)
    @versions = params[:data][:attributes][:formats]
    @alt_text = params[:data][:attributes][:alternativeText]
    @caption = params[:data][:attributes][:caption]
  end
end

# frozen_string_literal: true

class HeroImageComponent < ViewComponent::Base
  def initialize(params)
    super
    @params = params
  end
end

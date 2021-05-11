# frozen_string_literal: true

class PageCardComponent < ViewComponent::Base
  def initialize(params)
    super
    @params = params
  end
end

# frozen_string_literal: true

class Cms::FooterComponent < ViewComponent::Base
  attr_reader :data

  def initialize(data:)
    @data = data
  end

  private

  def get_model(key)
    @data.get_model(key)
  end
end

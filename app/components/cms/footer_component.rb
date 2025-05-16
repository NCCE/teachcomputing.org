# frozen_string_literal: true

class Cms::FooterComponent < ViewComponent::Base
  def initialize(data:)
    @data = data
  end

  def company_logo
    @data.data_models.first
  end

  def funding_logo
    @data.data_models.second
  end

  def link_blocks
    @data.data_models.last.link_block
  end
end

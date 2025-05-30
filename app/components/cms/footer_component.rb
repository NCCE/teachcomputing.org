# frozen_string_literal: true

class Cms::FooterComponent < ViewComponent::Base
  attr_reader :data

  def initialize(data:)
    @data = data
  end

  def company_logo
    data_models_by_type(Cms::Models::Images::Image).first
  end

  def funding_logo
    data_models_by_type(Cms::Models::Images::Image).second
  end

  def company_url
    find_text_field(0)&.value
  end

  def funding_url
    find_text_field(1)&.value
  end

  def link_blocks
    data_models_by_type(Cms::Models::Meta::FooterLinkBlock).first&.process_blocks
  end

  private

  def data_models_by_type(type)
    data.select { |model| model.is_a?(type) }
  end

  def find_text_field(index)
    data_models_by_type(Cms::Models::Data::TextField)[index]
  end
end

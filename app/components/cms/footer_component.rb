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

  def company_logo
    get_model(:company_logo).render
  end

  def company_logo_link
    get_model(:company_logo_link).value
  end

  def funder_logo
    get_model(:funder_logo).render
  end

  def funder_logo_link
    get_model(:funder_logo_link).value
  end

  def link_blocks
    get_model(:link_block).link_blocks
  end
end

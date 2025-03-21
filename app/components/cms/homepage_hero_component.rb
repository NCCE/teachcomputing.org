# frozen_string_literal: true

class Cms::HomepageHeroComponent < ViewComponent::Base
  def initialize(title:, house_content:, buttons:)
    @title = title
    @house_content = house_content
    @buttons = buttons
  end
end

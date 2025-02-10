# frozen_string_literal: true

class Cms::HeaderMenuComponent < ViewComponent::Base
  def initialize(menu_items:)
    @menu_items = menu_items
  end
end

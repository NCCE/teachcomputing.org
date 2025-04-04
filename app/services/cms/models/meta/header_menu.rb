module Cms
  module Models
    module Meta
      class HeaderMenu
        attr_accessor :menu_items

        def initialize(menu_items:)
          @menu_items = menu_items
        end

        def render
          Cms::HeaderMenuComponent.new(menu_items:)
        end
      end
    end
  end
end

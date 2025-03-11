module Cms
  module Models
    class HeaderMenu
      def initialize(menus)
        @menus = menus
      end

      def render
        Cms::HeaderMenuComponent.new(menu_items: @menus)
      end
    end
  end
end

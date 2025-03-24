module Cms
  module DynamicComponents
    module Blocks
      class HomepageHero
        attr_accessor :title, :house_content, :buttons

        def initialize(title:, house_content:, buttons:)
          @title = title
          @house_content = house_content
          @buttons = buttons
        end

        def render
          HomepageHeroComponent.new(title:, house_content:, buttons:)
        end
      end
    end
  end
end

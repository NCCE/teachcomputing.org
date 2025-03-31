module Cms
  module Models
    module BlogComponents
      class SimpleTitle
        attr_accessor :title

        def initialize(title:)
          @title = title
        end

        def render
          HeroComponent.new(title: title)
        end
      end
    end
  end
end

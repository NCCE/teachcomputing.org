module Cms
  module Models
    module DynamicComponents
      module Blocks
        class NumberedIconList < HasAsides
          attr_accessor :title, :title_icon, :points

          def initialize(title:, title_icon:, points:, aside_sections:)
            super(aside_sections)
            @title = title
            @title_icon = title_icon
            @points = points
          end

          def render
            Cms::NumberedIconListComponent.new(title:, title_icon:, points:, aside_sections:)
          end
        end
      end
    end
  end
end

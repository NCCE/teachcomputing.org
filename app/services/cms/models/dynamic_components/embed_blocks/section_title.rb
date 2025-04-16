module Cms
  module Models
    module DynamicComponents
      module EmbedBlocks
        class SectionTitle
          attr_accessor :title, :icon

          def initialize(title:, icon:)
            @title = title
            @icon = icon
          end

          def mappings
            {text: title, icon:}
          end

          def render
            SectionTitleWithIconComponent.new(**mappings)
          end
        end
      end
    end
  end
end

module Cms
  module Models
    module DynamicComponents
      module Blocks
        class CurriculumKeyStages
          attr_accessor :title, :background_color

          def initialize(title:, background_color:)
            @title = title
            @background_color = background_color
          end

          def render
            Cms::CurriculumKeyStagesComponent.new(title:, background_color:)
          end
        end
      end
    end
  end
end

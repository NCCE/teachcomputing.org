module Cms
  module Models
    module EnrichmentComponents
      class EnrichmentType
        attr_accessor :name, :icon

        def initialize(name:, icon:)
          @name = name
          @icon = icon
        end
      end
    end
  end
end

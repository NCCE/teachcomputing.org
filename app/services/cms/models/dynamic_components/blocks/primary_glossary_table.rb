module Cms
  module Models
    module DynamicComponents
      module Blocks
        class PrimaryGlossaryTable
          include ContainsCached

          attr_accessor :title

          def initialize(title:)
            @title = title
          end

          def render
            PrimaryGlossaryTableComponent.new(title:)
          end

          def clear_cache
            Cms::Collections::PrimaryGlossaryTableItems.clear_cache
          end
        end
      end
    end
  end
end

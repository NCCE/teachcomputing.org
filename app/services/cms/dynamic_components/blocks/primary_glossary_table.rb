module Cms
  module DynamicComponents
    module Blocks
      class PrimaryGlossaryTable
        attr_accessor :title

        def initialize(title:)
          @title = title
        end

        def render
          PrimaryGlossaryTableComponent.new(title:)
        end
      end
    end
  end
end

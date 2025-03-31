module Cms
  module Models
    module TextComponents
      class TextField
        attr_accessor :value

        def initialize(value:)
          @value = value
        end

        def render
          # has no render method, this exists just to provide data to model
        end
      end
    end
  end
end

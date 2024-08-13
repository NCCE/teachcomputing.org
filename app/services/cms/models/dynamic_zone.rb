module Cms
  module Models
    class DynamicZone
      def initialize(components)
        @components = components
      end

      def render
        CmsDynamicZoneComponent.new(@components)
      end
    end
  end
end

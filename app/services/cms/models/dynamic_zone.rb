module Cms
  module Models
    class DynamicZone
      def initialize(cms_models)
        @cms_models = cms_models
      end

      def render
        CmsDynamicZoneComponent.new(@cms_models)
      end
    end
  end
end

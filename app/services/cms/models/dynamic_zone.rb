module Cms
  module Models
    class DynamicZone
      attr_accessor :cms_models

      def initialize(cms_models:)
        @cms_models = cms_models
      end

      def render
        CmsDynamicZoneComponent.new(cms_models:)
      end
    end
  end
end

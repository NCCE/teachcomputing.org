module Cms
  module Models
    class DynamicZone
      attr_accessor :cms_models, :with_spacing

      def initialize(cms_models:, with_spacing: true)
        @cms_models = cms_models
        @with_spacing = with_spacing
      end

      def render
        CmsDynamicZoneComponent.new(cms_models:, with_spacing:)
      end
    end
  end
end

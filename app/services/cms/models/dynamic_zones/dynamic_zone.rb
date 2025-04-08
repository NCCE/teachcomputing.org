module Cms
  module Models
    module DynamicZones
      class DynamicZone
        include ContainsCached
        attr_accessor :cms_models

        def initialize(cms_models:)
          @cms_models = cms_models
        end

        def render
          Cms::DynamicZoneComponent.new(cms_models:)
        end

        def clear_cache
          @cms_models.each do |model|
            model.clear_cache if model.respond_to?(:clear_cache)
          end
        end
      end
    end
  end
end

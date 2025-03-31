module Cms
  module Models
    module DynamicZoneComponents
      class DynamicZone
        attr_accessor :cms_models

        def initialize(cms_models:)
          @cms_models = cms_models
        end

        def render
          Cms::DynamicZoneComponent.new(cms_models:)
        end
      end
    end
  end
end

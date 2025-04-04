module Cms
  module Models
    module DynamicComponents
      module Blocks
        class CommunityActivityGrid
          attr_accessor :title, :intro, :programme_activity_group_slug

          def initialize(title:, intro:, programme_activity_group_slug:)
            @title = title
            @intro = intro
            @programme_activity_group_slug = programme_activity_group_slug
          end

          def render
            CommunityActivityGridComponent.new(title:, intro:, programme_activity_group_slug:)
          end
        end
      end
    end
  end
end

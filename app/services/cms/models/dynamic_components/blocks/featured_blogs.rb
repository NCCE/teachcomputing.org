module Cms
  module Models
    module DynamicComponents
      module Blocks
        class FeaturedBlogs
          attr_accessor :title

          def initialize(title:)
            @title = title
          end

          def render
            FeaturedBlogPostsComponent.new(title:, number_to_display: 5, show_main_feature: true)
          end
        end
      end
    end
  end
end

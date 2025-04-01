module Cms
  module Providers
    module Strapi
      module Queries
        class HomepageDynamicZone
          HOMEPAGE_COMPONENTS = [
            Components::Blocks::BannerWithCards,
            Components::Blocks::FeaturedBlogs,
            Components::Blocks::FullWidthBanner,
            Components::Blocks::HomepageHero,
            Components::Blocks::PictureCardSection
          ]

          def self.embed(name)
            <<~GRAPHQL.freeze
              #{name} {
                __typename
                #{HOMEPAGE_COMPONENTS.map(&:fragment).join("\n")}
              }
            GRAPHQL
          end
        end
      end
    end
  end
end

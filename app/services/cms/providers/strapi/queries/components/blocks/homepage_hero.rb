module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class HomepageHero < BaseComponentQuery
              def self.name = "ComponentBlocksHomepageHero"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  houseText
                  #{Buttons::NcceButton.embed(:buttons)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end

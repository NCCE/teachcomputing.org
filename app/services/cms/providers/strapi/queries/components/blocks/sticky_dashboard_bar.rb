module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class StickyDashboardBar < BaseComponentQuery
              def self.name = "ComponentBlocksStickyDashboardBar"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{SharedFields.programme_slug}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end

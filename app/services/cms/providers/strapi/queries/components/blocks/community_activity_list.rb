module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class CommunityActivityList < BaseComponentQuery
              def self.name = "ComponentBlocksCommunityActivityList"

              def self.base_fields
                <<~GRAPHQL.freeze
                  intro
                  title
                  #{SharedFields.by_slug(:group)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end

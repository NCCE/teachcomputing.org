module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class CommunityActivityList < BaseComponentQuery
              def self.fields
                super("ComponentBlocksCommunityActivityList",
                  <<~GRAPHQL.freeze
                    intro
                    title
                    group {
                      data {
                        attributes {
                          slug
                        }
                      }
                    }
                  GRAPHQL
                )
              end
            end
          end
        end
      end
    end
  end
end

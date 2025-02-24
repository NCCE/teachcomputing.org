module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module EmailContent
            class Cta < BaseComponentQuery
              def self.name = "ComponentEmailContentCta"

              def self.base_fields
                <<~GRAPHQL.freeze
                  text
                  link
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end

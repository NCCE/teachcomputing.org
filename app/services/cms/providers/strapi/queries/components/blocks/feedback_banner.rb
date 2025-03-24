module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class FeedbackBanner < BaseComponentQuery
              def self.name = "ComponentBlocksFeedbackBanner"

              def self.base_fields
                <<~GRAPHQL.freeze
                  fbb__title: title
                  fbb__button: #{Buttons::NcceButton.embed(:button)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end

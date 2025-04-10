module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module EmbedBlocks
            class SectionTitle < BaseComponentQuery
              def self.name = "ComponentContentBlocksSectionTitle"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  #{SharedFields.image_fields(:icon)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end

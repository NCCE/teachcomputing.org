module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class PageTitle < BaseComponentQuery
              def self.name = "ComponentBlocksPageTitlte"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  subText
                  titleVideoUrl
                  #{SharedFields.image_fields("titleImage")}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end

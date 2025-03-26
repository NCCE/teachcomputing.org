module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class CurriculumKeyStages < BaseComponentQuery
              def self.name = "ComponentBlocksCurriculumKeyStages"

              def self.base_fields
                <<~GRAPHQL.freeze
                  cks__title: title
                  bkColor
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end

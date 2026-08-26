module Cms
  module Providers
    module Strapi
      module Queries
        class EnrichmentList
          def self.embed(name)
            <<~GRAPHQL.freeze
              #{name} (pagination: {limit: 100}) {
                publishedAt
                createdAt
                updatedAt
                #{SharedFields.image_fields(:partner_icon)}
                i_belong
                link
                featured
                terms { name }
                type {
                  name
                  #{SharedFields.image_fields(:icon)}
                }
                age_groups { name }
                rich_title
                rich_details
              }
            GRAPHQL
          end
        end
      end
    end
  end
end

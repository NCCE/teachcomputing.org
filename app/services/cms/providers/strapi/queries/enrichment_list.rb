module Cms
  module Providers
    module Strapi
      module Queries
        class EnrichmentList
          def self.embed(name)
            <<~GRAPHQL.freeze
              #{name} (pagination: {limit: 100}) {
                data {
                  id
                  attributes {
                    publishedAt
                    createdAt
                    updatedAt
                    #{SharedFields.image_fields(:partner_icon)}
                    i_belong
                    link
                    featured
                    terms { data { attributes { name }}}
                    type {
                      data {
                        attributes {
                          name
                          #{SharedFields.image_fields(:icon)}
                        }
                      }
                    }
                    age_groups { data { attributes { name }}}
                    rich_title
                    rich_details
                  }
                }
              }
            GRAPHQL
          end
        end
      end
    end
  end
end

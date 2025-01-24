module Cms
  module Providers
    module Strapi
      module Queries
        class EnrichmentList
          def self.embed(name)
            <<~GRAPHQL.freeze
              #{name} {
                data {
                  id
                  attributes {
                    #{SharedFields.image_fields(:partner_icon)}
                    i_belong
                    link
                    featured
                    terms { data { attributes { name }}}
                    type { data { attributes { name }}}
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

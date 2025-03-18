module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class TextWithTestimonial < BaseComponentQuery
              def self.name = "ComponentBlocksTextWithTestimonial"

              def self.base_fields
                <<~GRAPHQL.freeze
                  textContent
                  testimonialSide
                  #{Buttons::NcceButton.embed(:buttons)}
                  #{ContentBlocks::Testimonial.embed(:testimonial)}
                  #{SharedFields.color_theme(:bkColor)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end

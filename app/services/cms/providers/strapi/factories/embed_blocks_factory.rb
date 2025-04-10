module Cms
  module Providers
    module Strapi
      module Factories
        module EmbedBlocksFactory
          include BaseFactory

          def self.to_side_banner(strapi_data, key = :banner)
            return nil unless strapi_data[key]
            Models::DynamicComponents::EmbedBlocks::SideBanner.new(
              text_content: to_content_block(strapi_data[key][:textContent]),
              icon: to_image(strapi_data[key], :icon, default_size: :small),
              banner_color: extract_color_name(strapi_data[key], :bannerColor)
            )
          end

          def self.to_section_title(strapi_data, key = :gridRowTitle)
            return nil unless strapi_data[key]
            Models::DynamicComponents::EmbedBlocks::SectionTitle.new(
              title: strapi_data[key][:title],
              icon: to_image(strapi_data[key], :icon, default_size: :small)
            )
          end
        end
      end
    end
  end
end

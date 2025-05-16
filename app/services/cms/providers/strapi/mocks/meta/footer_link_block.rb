module Cms
  module Providers
    module Strapi
      module Mocks
        module Meta
          class FooterLinkBlock < StrapiMock
            attribute(:link_block) { Array.new(3) { DynamicComponents::ContentBlocks::LinkWithIcon.as_model } }
          end
        end
      end
    end
  end
end

module Cms
  module Providers
    module Strapi
      module Mocks
        module Singles
          class Footer < StrapiMock
            attribute(:companyLogo) { {data: Mocks::Images::Image.generate_raw_data} }
            attribute(:funderLogo) { {data: Mocks::Images::Image.generate_raw_data} }
            attribute(:companyLogoLink) { Faker::Internet.url }
            attribute(:funderLogoLink) { Faker::Internet.url }
            attribute(:linkBlock) { Array.new(4) { FooterLinkBlock.generate_data } }
          end

          class FooterLinkBlock < StrapiMock
            attribute(:link) { Array.new(4) { DynamicComponents::ContentBlocks::LinkWithIcon.generate_data } }
          end
        end
      end
    end
  end
end

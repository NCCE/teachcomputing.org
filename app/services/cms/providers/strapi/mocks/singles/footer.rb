module Cms
  module Providers
    module Strapi
      module Mocks
        module Singles
          class Footer < StrapiMock
            attribute(:companyLogo) { Mocks::Images::Image.as_model }
            attribute(:funderLogo) { Mocks::Images::Image.as_model }
            attribute(:companyLogoLink) { Faker::Internet.url }
            attribute(:funderLogoLink) { Faker::Internet.url }
            attribute(:linkBlock) { Meta::FooterLinkBlock.generate_data }
          end
        end
      end
    end
  end
end

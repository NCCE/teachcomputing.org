module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class MultiStateLink < StrapiMock
            attribute(:programme) { "i-belong" }

            attribute(:loggedOutLinkTitle) { Faker::Lorem.sentence }
            attribute(:loggedOutLink) { Faker::Internet.url }

            attribute(:notEnrolledLinkTitle) { Faker::Lorem.sentence }
            attribute(:notEnrolledLink) { Faker::Internet.url }

            attribute(:enrolledLinkTitle) { Faker::Lorem.sentence }
            attribute(:enrolledLink) { Faker::Internet.url }

          end
        end
      end
    end
  end
end

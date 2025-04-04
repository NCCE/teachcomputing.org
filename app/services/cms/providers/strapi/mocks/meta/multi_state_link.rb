module Cms
  module Providers
    module Strapi
      module Mocks
        module Meta
          class MultiStateLink < StrapiMock
            attribute(:programme) { ::Programme.i_belong }

            attribute(:loggedOutLinkTitle) { Faker::Lorem.sentence }
            attribute(:loggedOutLink) { Faker::Internet.url }

            attribute(:notEnrolledLinkTitle) { Faker::Lorem.sentence }
            attribute(:notEnrolledLink) { Faker::Internet.url }

            attribute(:enrolledLinkTitle) { Faker::Lorem.sentence }
            attribute(:enrolledLink) { Faker::Internet.url }

            def self.as_model(**)
              data = generate_data(**)
              Factories::ModelFactory.to_multi_state_link(data.except(:programme), data[:programme])
            end
          end
        end
      end
    end
  end
end

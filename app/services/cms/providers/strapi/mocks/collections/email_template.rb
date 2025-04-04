module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class EmailTemplate < StrapiMock
            attribute(:subject) { Faker::Lorem.sentence }
            attribute(:slug) { Faker::Internet.slug }
            attribute(:emailContent) { [] }
            attribute(:activityState) { "active" }
            attribute(:programme) {
              {data: {attributes: {slug: "primary-certificate"}}}
            }
            attribute(:completedGroupings) {
              {data: [{attributes: {slug: "primary-all-courses"}}]}
            }
          end
        end
      end
    end
  end
end

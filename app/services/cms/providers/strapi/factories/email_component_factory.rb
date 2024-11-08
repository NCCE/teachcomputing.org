module Cms
  module Providers
    module Strapi
      module Factories
        module EmailComponentFactory
          def self.process_component(strapi_data)
            component_name = strapi_data[:__component]
            case component_name
            when "email-content.text"
              EmailComponents::Text.new(
                blocks: strapi_data[:textContent]
              )
            when "email-content.cta"
              EmailComponents::Cta.new(
                text: strapi_data[:text],
                link: strapi_data[:link]
              )
            when "email-content.course-list"
              EmailComponents::CourseList.new(
                section_title: strapi_data[:sectionTitle],
                remove_on_match: strapi_data[:removeOnMatch],
                courses: strapi_data[:courses].map do |course|
                  EmailComponents::Course.new(
                    activity_code: course[:activityCode],
                    substitute: course[:substitute],
                    display_name: course[:displayName]
                  )
                end
              )
            end
          end
        end
      end
    end
  end
end

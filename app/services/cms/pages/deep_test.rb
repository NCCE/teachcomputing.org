module Cms
  module Pages
    class DeepTest < Resource
      def self.resource_attribute_mappings
        [
          {
            attribute: :title,
            component: HeroComponent,
            value_param: :title
          },
          {
            attribute: :container,
            component: nil,
            fields: [
              {
                attribute: :cardSection,
                fields: [
                  {
                    attribute: :cardHeaderImage
                  }
                ]
              }
            ]
          },
          {
            attribute: :resourceCards,
            component: nil,
            fields: [{
              attribute: :cardHeaderImage
            }]
          },
          {
            attribute: :anotherTest,
            component: nil,
            fields: [
              {attribute: :footerImage},
              {attribute: :headerImages}
            ]
          }
        ]
      end

      def self.resource_key
        "deep-test"
      end
    end
  end
end

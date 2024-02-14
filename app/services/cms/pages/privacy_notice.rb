module Cms
  module Pages
    class PrivacyNotice < Resource
      def self.resource_attribute_mappings
        {
          title: {
            component: HeroComponent,
            value_param: :title
          },
          content: {
            component: CmsRichTextBlockComponent,
            value_param: :blocks
          }
        }
      end

      def self.resource_key
        "privacy-notice"
      end
    end
  end
end

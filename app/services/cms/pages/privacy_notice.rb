module Cms
  module Pages
    class PrivacyNotice < Resource

      def self.attribute_mappings
        {
          title: {
            component: nil
          },
          content: {
            component: nil
          }
        }
      end

      def self.resource_key(params: nil)
        "privacy-notice"
      end

    end
  end
end

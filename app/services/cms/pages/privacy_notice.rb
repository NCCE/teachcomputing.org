module Cms
  module Pages
    class PrivacyNotice < Resource
      def self.resource_attribute_mappings
        [
          {model: Cms::Models::SimpleTitle, key: :title},
          {model: Cms::Models::ContentBlock, key: :content}
        ]
      end

      def self.resource_key
        "privacy-notice"
      end
    end
  end
end

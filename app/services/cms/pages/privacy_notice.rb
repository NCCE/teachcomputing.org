module Cms
  module Pages
    class PrivacyNotice < Resource
      def self.resource_attribute_mappings
        [
          {
            attribute: :title,
            component: CmsHeroComponent,
            value_param: :title
          },
          {
            attribute: :content,
            component: CmsRichTextBlockComponent,
            value_param: :blocks
          },
          #{
          #  attribute: :privacy_cookie_table,
          #  component: nil,
          #  fields: [
          #    {attribute: "cookieName"},
          #    {attribute: "cookieVariable"},
          #    {attribute: "purpose"}
          #  ]
          #}
        ]
      end

      def self.resource_key
        "privacy-notice"
      end
    end
  end
end

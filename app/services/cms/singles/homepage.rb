module Cms
  module Singles
    class Homepage < Resource
      def self.resource_attribute_mappings
        [
          {model: Cms::Models::Seo, key: :seo},
          {model: Cms::Models::HomepageDynamicZone, key: :content}
        ]
      end

      def self.graphql_key = "homepage"

      def self.resource_key = "homepage"
    end
  end
end

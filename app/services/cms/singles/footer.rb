module Cms
  module Singles
    class Footer < Resource
      def self.resource_attribute_mappings
        [
          {model: Models::Images::Image, key: :companyLogo},
          {model: Models::Images::Image, key: :funderLogo},
          {model: Models::Meta::FooterLinkBlock, key: :linkBlock }
        ]
      end

      def self.cache_expiry
        15.minutes
      end

      def self.resource_key = "footer"

      def self.graphql_key = "footer"
    end
  end
end

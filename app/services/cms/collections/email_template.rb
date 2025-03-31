module Cms
  module Collections
    class EmailTemplate < Resource
      def self.is_collection = true

      def self.collection_attribute_mapping
        [
          {model: Models::EmailTemplate, key: nil, param_name: :template}
        ]
      end

      def self.resource_attribute_mappings
        [
          {model: Models::EmailTemplate, key: nil, param_name: :template}
        ]
      end

      def self.cache_expiry
        return 10.seconds if Rails.env.staging?
        15.minutes
      end

      def self.resource_key = "email-templates"

      def self.graphql_key = "emailTemplates"
    end
  end
end

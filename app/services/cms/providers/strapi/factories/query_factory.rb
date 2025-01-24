module Cms
  module Providers
    module Strapi
      module Factories
        module QueryFactory
          def self.key_type
            case Rails.application.config.strapi_connection_type
            when "rest"
              "$eq"
            when "graphql"
              "eq"
            end
          end

          def self.generate_parameters(collection_class, query)
            filter = {}
            if collection_class == Cms::Collections::Blog
              filter[:featured] = {key_type => query[:featured]} if query[:featured]
              filter[:blog_tags] = {slug: {key_type => query[:tag]}} if query[:tag]
            end
            filter
          end
        end
      end
    end
  end
end

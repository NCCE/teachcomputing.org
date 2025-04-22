module Cms
  module Providers
    module Strapi
      module Factories
        module QueryFactory
          def self.key_type(function)
            case Rails.application.config.strapi_connection_type
            when "rest"
              "$#{function}"
            when "graphql"
              function
            end
          end

          def self.generate_parameters(collection_class, query)
            filter = {}
            if collection_class == Cms::Collections::Blog
              filter[:publishDate] = {key_type("lt") => DateTime.now.strftime}
              filter[:featured] = {key_type("eq") => query[:featured]} if query&.dig(:featured)
              filter[:blog_tags] = {slug: {key_type("eq") => query[:tag]}} if query&.dig(:tag)
            elsif collection_class == Cms::Collections::SiteWideBanner
              current_time = DateTime.now.strftime
              filter[:endTime] = {key_type("gte") => current_time}
            end
            filter
          end
        end
      end
    end
  end
end

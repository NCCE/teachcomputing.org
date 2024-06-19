module Cms
  module Providers
    module Strapi
      module Factories
        module QueryFactory
          def self.generate_parameters(collection_class, query)
            filter = {}
            if collection_class == Cms::Collections::Blog
              filter[:featured] = {"$eq": query[:featured]} if query[:featured]
              filter[:blog_tags] = {slug: {"$eq": query[:tag]}} if query[:tag]
            end
            filter
          end
        end
      end
    end
  end
end

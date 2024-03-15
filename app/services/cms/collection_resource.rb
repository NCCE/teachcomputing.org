module Cms
  class CollectionResource < Resource
    def self.collection_attribute_mappings
      []
    end

    def self.all(page, page_size, params: {})
      response = Cms::Request.all(self, page, page_size, params)
      response[:resources].map! { new(**_1) }
      Collection.new(**response)
    end
  end
end

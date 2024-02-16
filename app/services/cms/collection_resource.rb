module Cms
  class CollectionResource < Resource
    def collection_view
      mapping = self.class.collection_attribute_mappings
      values = attributes.slice(*self.class.collection_view_fields)
      flattened_keys = values.transform_keys { |key| key.to_s.underscore.to_sym }
      mapping[:component].new(**flattened_keys)
    end

    def self.collection_view_fields
      collection_attribute_mappings[:fields].collect { _1[:attribute] }
    end

    def self.collection_attribute_mappings
      raise NotImplementedError
    end

    def self.all(page, page_size, params: {})
      response = Cms::Request.all(self, page, page_size, params)
      response[:resources].map! { new(**_1) }
      Collection.new(**response)
    end
  end
end

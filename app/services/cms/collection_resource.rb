module Cms
  class CollectionResource < Resource
    def self.all(page, page_size)
      params = attribute_mappings.keys.to_h { ["populate[#{_1}]", "*"] }
      response = Cms::Request.all(resource_key, page, page_size, params)
      response[:resources].map!{ new(**_1) }
      Collection.new(**response)
    end
  end
end

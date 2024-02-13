module Cms
  class Resource
    attr_accessor :id, :attributes, :created_at, :updated_at, :published_at

    def initialize(id:, attributes:, created_at:, updated_at:, published_at:)
      @id = id
      @attributes = attributes
      @created_at = DateTime.parse(created_at)
      @updated_at = DateTime.parse(updated_at)
      @published_at = DateTime.parse(published_at)
    end

    def self.attribute_mappings
      raise NotImplementedError
    end

    def self.resource_key(params: {})
      raise NotImplementedError
    end

    def self.get(params: {})
      populate_params = attribute_mappings.keys.to_h { ["populate[#{_1}]", "*"] }
      data = Cms::Request.one(resource_key(params:), populate_params)
      new(**data)
    end
  end
end

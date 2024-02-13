module Cms
  class Resource
    attr_accessor :id, :attributes, :created_at, :updated_at, :published_at

    def initialize(id:, attributes:)
      @id = id
      @attributes = attributes
      @createdAt = DateTime.parse(@attributes[:createdAt])
      @updatedAt = DateTime.parse(@attributes[:updatedAt])
      @publishedAt = DateTime.parse(@attributes[:publishedAt])
    end

    def self.attribute_mappings
      raise NotImplementedError
    end

    def self.resource_key(params: {})
      raise NotImplementedError
    end

    def self.get
      params = attribute_mappings.keys.to_h { ["populate[#{_1}]", "*"] }
      data = Cms::Request.one(resource_key, params)
      new(**data)
    end
  end
end

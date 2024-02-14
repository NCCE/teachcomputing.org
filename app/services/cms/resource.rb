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

    def resource_view(component)
      values = {}
      values[component[:value_param]] = attribute_value(component)
      component[:component].new(**values)
    end

    def attribute_value(component)
      attributes[component[:attribute]]
    end

    def self.resource_attribute_mappings
      raise NotImplementedError
    end

    def self.resource_key
      raise NotImplementedError
    end

    def self.get(params: {})
      data = Cms::Request.one(self, params)
      new(**data)
    end

    def self.required_fields
      [:created_at, :updated_at, :published_at]
    end
  end
end

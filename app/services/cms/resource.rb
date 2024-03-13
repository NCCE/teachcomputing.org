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
      if component[:value_param]
        values[component[:value_param]] = attribute_value(component)
      else
        values = attribute_value(component)
      end
      component[:component].new(self, **values) if values
    end

    def attribute_mapping(attribute_name)
      self.class.resource_attribute_mappings.find { _1[:attribute] == attribute_name }
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

    def self.get(params: {}, preview: false, preview_key: nil)
      data = Cms::Request.one(self, params, preview:, preview_key:)
      new(**data)
    end

    def self.clear_cache
      Cms::Request.clear_page_cache(self)
    end

    def self.required_fields
      [:created_at, :updated_at, :published_at]
    end
  end
end

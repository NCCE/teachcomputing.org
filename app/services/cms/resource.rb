module Cms
  class Resource
    attr_accessor :id, :created_at, :updated_at, :published_at, :data_models

    def initialize(id:, data_models:, created_at:, updated_at:, published_at:)
      @id = id
      @data_models = data_models
      @created_at = DateTime.parse(created_at)
      @updated_at = DateTime.parse(updated_at)
      @published_at = DateTime.parse(published_at)
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
  end
end

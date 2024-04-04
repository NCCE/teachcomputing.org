module Cms
  class Resource
    CACHE_EXPIRY = 4.hours

    attr_accessor :id, :created_at, :updated_at, :published_at, :data_models

    def initialize(id:, data_models:, created_at:, updated_at:, published_at:)
      @id = id
      @data_models = data_models
      @created_at = DateTime.parse(created_at)
      @updated_at = DateTime.parse(updated_at)
      @published_at = DateTime.parse(published_at)
    end

    def to_search_record(index_time)
      raise NotImplementedError
    end

    def self.is_collection = false

    def self.resource_attribute_mappings
      raise NotImplementedError
    end

    def self.resource_key
      raise NotImplementedError
    end

    def self.get(resource_id = nil, preview: false, preview_key: nil)
      data = if preview
        # dont use cache for previews
        client.one(self, resource_id, preview:, preview_key:)
      else
        key = if resource_id
          "#{resource_key}-#{resource_id}"
        else
          resource_key
        end
        Rails.cache.fetch(
          key,
          expires_in: CACHE_EXPIRY,
          namespace: "cms"
        ) do
          client.one(self, resource_id)
        end
      end
      new(**data)
    end

    def self.collection_attribute_mappings
      raise Errors::NotACmsCollection unless is_collection
      []
    end

    def self.all(page, page_size, params: {})
      raise Errors::NotACmsCollection unless is_collection
      response = Rails.cache.fetch(
        "#{resource_key}-#{page}-#{page_size}",
        expires_in: CACHE_EXPIRY,
        namespace: "cms"
      ) do
        client.all(self, page, page_size, params)
      end
      response[:resources].map! { new(**_1) }
      Collection.new(**response)
    end

    def self.clear_cache(key = nil)
      if key
        Rails.cache.delete("#{resource_key}-#{key}", namespace: "cms")
      else
        Rails.cache.delete_matched(/#{resource_key}.*/, namespace: "cms")
      end
    end

    private_class_method def self.client
      case Rails.application.config.cms_provider
      when "strapi"
        Providers::Strapi::Client.new
      else
        raise Errors::NoCmsProviderDefined
      end
    end
  end
end

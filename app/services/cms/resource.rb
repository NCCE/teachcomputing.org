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

    def to_search_record(index_time)
      raise NotImplementedError
    end

    def respond_to_missing?(method_name, include_private = false)
      self.class.param_indexes.key?(method_name) || super
    end

    def method_missing(method_name)
      index = self.class.param_indexes[method_name]
      data_models[index]
    end

    def self.param_name(mapping)
      return mapping[:param_name] if mapping.has_key?(:param_name)
      mapping[:key].to_s.underscore.to_sym
    end

    def self.param_indexes
      resource_attribute_mappings.each_with_object({}).with_index do |(mapping, indexes), index|
        indexes[param_name(mapping)] = index
      end
    end

    def self.is_collection = false

    def self.resource_attribute_mappings
      raise NotImplementedError
    end

    def self.resource_key
      raise NotImplementedError
    end

    def self.graphql_key
      raise NotImplementedError
    end

    def self.sort = nil

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
          expires_in: cache_expiry,
          namespace: "cms"
        ) do
          client.one(self, resource_id)
        end
      end
      new(**data)
    end

    def self.cache_expiry
      4.hours
    end

    def self.collection_attribute_mappings
      raise Errors::NotACmsCollection unless is_collection
      []
    end

    def self.all(page, page_size, params: {})
      raise Errors::NotACmsCollection unless is_collection
      response = Rails.cache.fetch(
        cache_key(page, page_size, params),
        expires_in: cache_expiry,
        namespace: "cms"
      ) do
        client.all(self, page, page_size, params)
      end
      response[:resources].map! { new(**_1) }
      Collection.new(**response)
    end

    def self.all_records(params: {})
      page = 1
      per_page = 100
      all_records = []

      loop do
        records = all(page, per_page, params:)
        all_records += records.resources

        break if (page * per_page) > records.total_records
        page += 1
      end
      all_records
    end

    def self.clear_cache(key = nil)
      if key
        Rails.cache.delete("#{resource_key}-#{key}", namespace: "cms")
      else
        Rails.cache.delete_matched(/#{resource_key}.*/, namespace: "cms")
      end
    end

    private_class_method def self.cache_key(page, page_size, params)
      if params.empty?
        "#{resource_key}-#{page}-#{page_size}"
      else
        "#{resource_key}-#{page}-#{page_size}-#{flatten_params(params)}"
      end
    end

    private_class_method def self.flatten_params(hsh)
      hsh.map do |k, v|
        if v.is_a?(Hash)
          "#{k}_#{flatten_params(v)}"
        else
          "#{k}_#{v}"
        end
      end.join("-")
    end

    private_class_method def self.client
      case Rails.application.config.cms_provider
      when "strapi"
        case Rails.application.config.strapi_connection_type
        when "rest"
          Providers::Strapi::Client.new
        when "graphql"
          if Rails.env.test?
            Providers::Strapi::GraphqlClient.new(schema_path: StrapiStubs::GRAPH_SCHEMA)
          else
            Providers::Strapi::GraphqlClient.new
          end
        else
          Providers::Strapi::Client.new
        end
      else
        raise Errors::NoCmsProviderDefined
      end
    end
  end
end

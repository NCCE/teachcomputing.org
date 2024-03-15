module Cms
  class Request
    CACHE_EXPIRY = 12.hours

    def self.one(resource_class, params, preview: false, preview_key: nil)
      if preview
        # dont use cache for previews
        client.one(resource_class, params, preview:, preview_key:)
      else
        Rails.cache.fetch(
          resource_class.resource_key,
          expires_in: CACHE_EXPIRY,
          namespace: "cms"
        ) do
          client.one(resource_class, params)
        end
      end
    end

    def self.clear_page_cache resource_class
      Rails.cache.delete(resource_class.resource_key, namespace: "cms")
    end

    def self.all(resource_class, page, page_size, params)
      Rails.cache.fetch(
        "#{resource_class.resource_key}-#{page}-#{page_size}",
        expires_in: CACHE_EXPIRY,
        namespace: "cms"
      ) do
        client.all(resource_class, page, page_size, params)
      end
    end

    private_class_method def self.client
      case (ENV["CMS_PROVIDER"])
      when "strapi"
        Providers::Strapi::Client.new
      else
        raise StandardError
      end
    end
  end
end

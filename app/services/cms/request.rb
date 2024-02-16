module Cms
  class Request
    CACHE_EXPIRY = 12.hours

    def self.one(resource_class, params)
      Rails.cache.fetch(
        resource_class.resource_key,
        expires_in: CACHE_EXPIRY,
        namespace: "cms"
      ) do
        connection.one(resource_class, params)
      end
    end

    def self.all(resource_class, page, page_size, params)
      Rails.cache.fetch(
        "#{resource_class.resource_key}-#{page}-#{page_size}",
        expires_in: CACHE_EXPIRY,
        namespace: "cms"
      ) do
        connection.all(resource_class, page, page_size, params)
      end
    end

    private_class_method def self.connection
      case (ENV["CMS_PROVIDER"])
      when "strapi"
        Providers::Strapi::Client.new
      else
        raise StandardError
      end
    end
  end
end

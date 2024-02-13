module Cms
  class Request
    CACHE_EXPIRY = 12.hours

    def self.one(resource_path, params)
      Rails.cache.fetch(
        resource_path,
        expires_in: CACHE_EXPIRY,
        namespace: "cms"
      ) do
        connection.one(resource_path, params)
      end
    end

    def self.all(resource_path, page, page_size, params)
      Rails.cache.fetch(
        "#{resource_path}-#{page}-#{page_size}",
        expires_in: CACHE_EXPIRY,
        namespace: "cms"
      ) do
        connection.all(resource_path, page, page_size, params)
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

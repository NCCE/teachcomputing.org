module Cms
  module Providers
    module Strapi
      class Connection
        def self.api
          config = Rails.application.config
          Faraday.new(url: config.strapi_api_url) do |connection|
            connection.adapter :net_http
            connection.request :authorization, :Bearer, config.strapi_api_key
          end
        end
      end
    end
  end
end

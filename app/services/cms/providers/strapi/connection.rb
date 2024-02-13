module Cms
  module Providers
    module Strapi
      class Connection
        API_TOKEN = ENV["STRAPI_API_KEY"]
        URL = ENV["STRAPI_URL"]

        def self.api
          Faraday.new(url: URL) do |connection|
            connection.adapter :net_http
            connection.authorization :Bearer, API_TOKEN
          end
        end
      end
    end
  end
end

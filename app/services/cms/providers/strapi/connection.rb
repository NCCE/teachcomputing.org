module Cms
  module Providers
    module Strapi
      class Connection
        def self.api
          config = Strapi.configuration
          puts config
          Faraday.new(url: config.api_url) do |connection|
            connection.adapter :net_http
            connection.authorization :Bearer, config.api_key
          end
        end
      end
    end
  end
end

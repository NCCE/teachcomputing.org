module Cms
  module Providers
    module Strapi
      class Connection
        class << self
          def api
            config = Rails.application.config
            Faraday.new(url: config.strapi_api_url) do |connection|
              connection.adapter :net_http
              connection.authorization :Bearer, config.strapi_api_key
            end
          end
        end
      end
    end
  end
end

module Credly
  class Connection
    API_TOKEN = Rails.application.config.credly_auth_token.freeze
    URL = Rails.application.config.credly_url.freeze

    def self.connect
      Faraday.new(url: URL) do |conn|
        conn.adapter :net_http
        conn.request(:authorization, :basic, API_TOKEN, "")
      end
    end
  end
end

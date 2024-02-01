module Credly
  class Connection
    API_TOKEN = ENV["CREDLY_AUTH_TOKEN"]
    URL = "https://api.credly.com/v1/".freeze

    def self.connect
      Faraday.new(url: URL) do |conn|
        conn.adapter :net_http
        conn.request(:basic_auth, API_TOKEN, "")
      end
    end
  end
end

module Credly
  class Connection
    API_TOKEN = ENV['CREDLY_AUTH_TOKEN'].freeze
    URL = 'https://api.credly.com/v1/'

    def self.connect
      Faraday.new(url: URL) do |conn|
        conn.adapter :net_http
        conn.basic_auth(API_TOKEN, '')
      end
    end
  end
end

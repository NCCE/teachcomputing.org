module Credly
  class Connection
    def initialize
      @api_token = ENV['CREDLY_AUTH_TOKEN']
      @url = 'https://api.credly.com/v1/'
    end

    def self.connect
      Faraday.new(url: @url) do |conn|
        conn.basic_auth(@api_token, '')
      end
    end
  end
end

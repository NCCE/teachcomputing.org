require "faraday"

class Achiever::Connection
  def self.api
    Faraday.new(url: ENV.fetch("ACHIEVER_V2_ENDPOINT")) do |conn|
      conn.adapter :net_http
      conn.request(:authorization, :basic, ENV.fetch("ACHIEVER_V2_USERNAME"), ENV.fetch("ACHIEVER_V2_PASSWORD"))
      conn.proxy = ENV.fetch("PROXY_URL") # set PROXY_URL='' if you don't need a proxy
    end
  end
end

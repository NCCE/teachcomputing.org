require "faraday"
require "openssl"

class Achiever::Connection
  def self.api
    Faraday.new(url: ENV.fetch("ACHIEVER_V2_ENDPOINT")) do |conn|
      conn.adapter :net_http
      conn.request(:authorization, :basic, ENV.fetch("ACHIEVER_V2_USERNAME"), ENV.fetch("ACHIEVER_V2_PASSWORD"))
      conn.proxy = ENV.fetch("PROXY_URL").presence # set PROXY_URL='' if you don't need a proxy
    end
  end

  # Persists across server restarts (unlike :memory_store) so repeat local requests for the
  # same Achiever query don't need a live round trip once cached.
  def self.dev_cache_store
    @dev_cache_store ||= ActiveSupport::Cache::FileStore.new(Rails.root.join("tmp/cache/achiever"))
  end
end

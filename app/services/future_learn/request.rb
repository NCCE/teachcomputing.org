module FutureLearn
  CACHE_EXPIRY = 5.hours

  class Request
    def self.run(endpoint, params = [])
      @connection = Connection.connect

      endpoint = "#{endpoint}/#{Array.wrap(params).join('/')}" unless params.empty?
      res = Rails.cache.fetch(endpoint, expires_in: CACHE_EXPIRY) do
        res = @connection.get(endpoint)
      end

      JSON.parse(res.body, symbolize_names: true)
    end
  end
end

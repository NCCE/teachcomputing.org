module FutureLearn
  CACHE_EXPIRY = 5.hours

  class Request
    def self.run(endpoint, params = {})
      @connection = Connection.connect

      params_str = params.map { |_, v| v }.join('-')
      res = Rails.cache.fetch("#{endpoint}-#{params_str}", expires_in: CACHE_EXPIRY) do
        res = @connection.get(endpoint, params)
      end

      JSON.parse(res.body, object_class: OpenStruct)
    end
  end
end

module FutureLearn
  CACHE_EXPIRY = 5.hours

  class Request
    def self.run(endpoint, params = [])
      @connection = Connection.connect

      endpoint_with_params = "#{endpoint}/#{params.join('/')}"
      res = Rails.cache.fetch(endpoint_with_params, expires_in: CACHE_EXPIRY) do
        res = @connection.get(endpoint_with_params)
      end

      JSON.parse(res.body, object_class: OpenStruct)
    end
  end
end

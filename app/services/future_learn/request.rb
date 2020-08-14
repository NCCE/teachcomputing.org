module FutureLearn
  JWT_ALGORITHM = 'HS256'.freeze
  CACHE_EXPIRY = 5.hours
  BASE_URL = ENV.fetch('FL_LTI_API_URL').freeze

  class Request
    def self.run(endpoint, params = {})
      @jwt = create_jwt unless @expiry && @expiry > Time.now

      url = "#{BASE_URL}/#{endpoint}"
      headers = {
        :Authorization => "Bearer #{@jwt}",
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      params_str = params.map { |_, v| v }.join('-')
      res = Rails.cache.fetch("#{endpoint}-#{params_str}", expires_in: CACHE_EXPIRY) do
        res = Faraday.get(url, params, headers)
      end

      handle_response(res)
    end

    def self.handle_response(res)
      case res.status
      when 302
        JSON.parse(res.body)
      when 401
        raise FutureLearn::Errors::AuthorizationError, "Failed to connect to #{BASE_URL}"
      when 404
        Rails.logger.warn "#{Request.name} Record not found"
        {}
      end
    end

    def self.create_jwt
      now = Time.now
      @expiry = now + 10.minutes
      payload = {
        iss: ENV.fetch('FL_LTI_API_CONSUMER_KEY'),
        iat: now.to_i,
        exp: @expiry.to_i
      }
      JWT.encode payload, ENV.fetch('FL_LTI_API_CONSUMER_SECRET'), JWT_ALGORITHM
    end
  end
end

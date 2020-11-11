module FutureLearn
  BASE_URL = ENV.fetch('FL_PARTNERS_URL').freeze
  KEY = ENV.fetch('FL_PARTNERS_CONSUMER_KEY').freeze
  SECRET = ENV.fetch('FL_PARTNERS_CONSUMER_SECRET').freeze
  JWT_ALGORITHM = 'HS256'.freeze

  class Connection
    # Don't memoize this as the jwt will expire, if unavoidable use it conditionally
    # with `jwt_valid?`
    def self.connect
      @jwt = create_jwt unless jwt_valid?
      Faraday.new(
        url: BASE_URL,
        headers: {
          :Authorization => "Bearer #{@jwt}",
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
      ) do |c|
        c.use Faraday::Response::RaiseError
      end
    end

    def self.create_jwt
      now = Time.now
      @expiry = now + 90.seconds
      payload = {
        iss: KEY,
        iat: now.to_i,
        exp: @expiry.to_i
      }
      JWT.encode payload, SECRET, JWT_ALGORITHM
    end

    def self.jwt_valid?
      @expiry && @expiry > Time.now
    end
  end
end

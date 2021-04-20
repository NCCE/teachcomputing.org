module Credly
  CACHE_EXPIRY = 12.hours.freeze
  SUCCESS = [201, 200].freeze

  class Request
    def self.run(resource_path, body = {})
      connection = Credly::Connection.connect

      if body.empty?
        response = Rails.cache.fetch(resource_path, expires_in: CACHE_EXPIRY) do
          response = connection.get(resource_path)
        end
      else
        response = connection.post(resource_path, body, 'Content-Type' => 'application/json')
      end

      raise Credly::Error.new(failure: { status: response.status, reason: response.body }) unless SUCCESS.include?(response.status)

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end

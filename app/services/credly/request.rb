module Credly
  CACHE_EXPIRY = 12.hours

  class Request
    def self.run(resource_path, body = {})
      connection = Credly::Connection.new.connect

      # request = Rails.cache.fetch(resource_path, expires_in: CACHE_EXPIRY) do
        request = connection.get(resource_path)
      # end

      byebug
      JSON.parse(request.body, symbolize_names: true)
    end
  end
end

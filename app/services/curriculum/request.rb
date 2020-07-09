module Curriculum
  class Request
    def self.run(query, params = {}, client = nil)
      client ||= Curriculum::Connection.connect

      unless client.is_a?(Graphlient::Client)
        raise Curriculum::Errors::ConnectionError, 'Invalid or missing Graphlient::Client, unable to connect'
      end

      begin
        response = client.execute(client.parse(query), params)
      rescue Graphlient::Errors::ServerError
        raise Curriculum::Errors::ConnectionError, "Unable to connect to: #{Curriculum::Connection::CURRICULUM_API_URL}"
      end

      response.data
    end
  end
end

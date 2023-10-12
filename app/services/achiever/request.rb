class Achiever::Request
  class << self
    CACHE = true
    CACHE_EXPIRY = 1.day

    def option_sets(resource_path, query = {})
      query_string = query_strings(query)

      response = perform_request(query_string, resource_path, CACHE, 1.day, 20.seconds)

      parsed_response = parse_response(response.body)

      if success?(response, parsed_response)
        parsed_response.GetJsonResult.OptionSetsClean
      else
        raise Achiever::Error.new(failure: { status: response.status,
                                             reason: parsed_response.GetJsonResult.FailureReason })
      end
    end

    def resource(resource_path, query = {}, cache = CACHE, cache_expiry = CACHE_EXPIRY)
      query_string = query_strings(query)

      response = perform_request(query_string, resource_path, cache, cache_expiry)
      parsed_response = parse_response(response.body)

      if success?(response, parsed_response)
        parsed_response.GetJsonResult.Entities
      else
        Rails.logger.warn "Achiever::Request error: #{parsed_response.GetJsonResult.FailureReason}"
        []
      end
    rescue JSON::ParserError => e
      Rails.logger.warn "Achiever::Request Error parsing JSON: #{e.message}"
      []
    end

    def resource_post(resource_path, body)
      response = api.post(resource_path, body)

      parsed_response = parse_response(response.body)

      unless parsed_response.FailureReason.blank?
        raise Achiever::Error.new(failure: { status: response.status,
                                             reason: parsed_response.FailureReason })
      end

      parsed_response
    end

    private

      def perform_request(query_string, resource_path, cache, cache_expiry, race_condition_ttl = nil)
        return api.get("#{resource_path}&#{query_string}") unless cache

        Rails.cache.fetch(
          "#{resource_path}&#{query_string}",
          expires_in: cache_expiry,
          race_condition_ttl:,
          namespace: 'achiever'
        ) do
          next local_response(resource_path) if ActiveRecord::Type::Boolean.new.cast(ENV.fetch('ACHIEVER_USE_LOCAL_TEMPLATES', 'false')) && Rails.env.development?
          api.get("#{resource_path}&#{query_string}")
        end
      end

      def success?(response, parsed_response)
        response.status == 200 && parsed_response.GetJsonResult.FailureReason.blank?
      end

      def query_strings(query)
        query.map { |k, v| "#{k}=#{v}" }.join('&')
      end

      def parse_response(response_body)
        JSON.parse(response_body, object_class: OpenStruct)
      end

      def api
        Achiever::Connection.api
      end

      def local_response(resource_path)
        raise Error, 'Missing ACHIEVER_LOCAL_TEMPLATE_PATH' unless ENV['ACHIEVER_LOCAL_TEMPLATE_PATH'].present?

        matches = /Get\?cmd=(.*)/.match(resource_path)
        endpoint = matches[1]&.to_sym

        begin
          path = "#{ENV.fetch('ACHIEVER_LOCAL_TEMPLATE_PATH')}/#{endpoint&.downcase}.json"
          OpenStruct.new(body: File.new(path).read, status: 200)
        rescue KeyError
          raise KeyError, "No mapping exists for #{matches[1]}"
        rescue Errno::ENOENT
          raise Errno::ENOENT, "No local template could be found for the achiever endpoint '#{endpoint}' in '#{path}'"
        end
      end
  end
end

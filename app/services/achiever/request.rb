# rubocop:disable Metrics/AbcSize

class Achiever::Request
  class << self
    CACHE = true
    CACHE_EXPIRY = 1.day

    def option_sets(resource_path, query = {})
      query_string = query_strings(query)

      response = Rails.cache.fetch(
        resource_path,
        expires_in: 1.day,
        race_condition_ttl: 20.seconds,
        namespace: 'achiever'
      ) do
        api.get("#{resource_path}&#{query_string}")
      end

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

      response = if cache
                   Rails.cache.fetch(resource_path, expires_in: cache_expiry) do
                     api.get("#{resource_path}&#{query_string}")
                   end
                 else
                   api.get("#{resource_path}&#{query_string}")
                 end

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
  end
end

# rubocop:enable Metrics/AbcSize

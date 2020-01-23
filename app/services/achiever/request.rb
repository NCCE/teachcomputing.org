class Achiever::Request
  class << self
    def option_sets(resource_path, query = {})
      query_string = query_strings(query)

      response = Rails.cache.fetch(resource_path, expires_in: 1.day) do
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

    def get_resource(resource_path, query = {}, cache = true)
      query_string = query_strings(query)

      if cache
        response = Rails.cache.fetch(resource_path, expires_in: 1.day) do
          api.get("#{resource_path}&#{query_string}")
        end
      else
        response = api.get("#{resource_path}&#{query_string}")
      end
            
      parsed_response = parse_response(response.body)

      if success?(response, parsed_response)
        parsed_response.GetJsonResult.Entities
      else
        raise Achiever::Error.new(failure: { status: response.status,
                                             reason: parsed_response.GetJsonResult.FailureReason })
      end
    end

    def post_resource(resource_path, body)
      response = api.post(resource_path, body)

      parsed_response = parse_response(response.body)

      unless success?(response, parsed_response)
        raise Achiever::Error.new(failure: { status: response.status, reason: parsed_response.GetJsonResult.FailureReason })
      end
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

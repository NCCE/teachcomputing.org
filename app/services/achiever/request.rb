class Achiever::Request
  class << self

    def option_sets(resource_path, query = {})
      query_string = query_strings(query)
      response = api.get("#{resource_path}&#{query_string}")
      parsed_response = parse_response(response)

      if success?(response, parsed_response)
        parsed_response.GetJsonResult.OptionSetsClean
      else
        raise Achiever::Error.new(failure: { status: response.status,
                                             reason: parsed_response.GetJsonResult.FailureReason })
      end
    end

    def resource(resource_path, query = {})
      query_string = query_strings(query)
      response = api.get("#{resource_path}&#{query_string}")
      parsed_response = parse_response(response)

      if success?(response, parsed_response)
        parsed_response.GetJsonResult.Entities
      else
        raise Achiever::Error.new(failure: { status: response.status,
                                             reason: parsed_response.GetJsonResult.FailureReason })
      end
    end

    private

    def success?(response, parsed_response)
      response.status != 200 || parsed_response.GetJsonResult.FailureReason.blank?
    end

    def query_strings(query)
      query.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    def parse_response(response)
      JSON.parse(response.body, object_class: OpenStruct)
    end

    def api
      Achiever::Connection.api
    end
  end
end

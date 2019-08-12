module AchieverStubs
  def stub_age_groups
    json_response = File.new('spec/support/achiever/courses/age_groups.json')
    stub_request(:get, 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?Page=1&RecordCount=1000&cmd=OptionsetAgeGroups').to_return(body: json_response)
  end

  def stub_course_templates
    json_response = File.new('spec/support/achiever/courses/templates.json')
    stub_request(:get, 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?HideFromweb=0&Page=1&ProgrammeID=f64aed56-c1b0-e911-a82c-002248008902&RecordCount=1000&cmd=CourseTemplatesListingByProgramme').to_return(body: json_response)
  end

  def stub_a_failed_response(method, query)
    json_response = File.new('spec/support/achiever/failure.json')
    query_strings = query.map { |k, v| "#{k}=#{v}" }.join('&')
    stub_request(:any, "https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=#{method}&#{query_strings}").to_return(body: json_response)
  end
end
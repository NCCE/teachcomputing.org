module AchieverStubs
  def stub_age_groups
    json_response = File.new('spec/support/achiever/courses/age_groups.json')
    stub_request(:get, 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=Get?cmd=OptionsetAgeGroups').to_return(body: json_response)
  end

  def stub_course_templates
    json_response = File.new('spec/support/achiever/courses/templates.json')
    stub_request(:get, 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=Get?cmd=CourseTemplatesListingByProgramme').to_return(body: json_response)
  end

  def stub_a_failed_response(method)
    json_response = File.new('spec/support/achiever/failure.json')
    stub_request(:any, "https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=Get?cmd=#{method}").to_return(body: json_response)
  end
end

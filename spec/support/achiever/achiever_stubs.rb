module AchieverStubs
  def stub_a_failed_response(method, query)
    json_response = File.new('spec/support/achiever/failure.json')
    query_strings = query.map { |k, v| "#{k}=#{v}" }.join('&')
    stub_request(:any, "https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=#{method}&#{query_strings}").to_return(body: json_response)
  end

  def stub_age_groups
    json_response = File.new('spec/support/achiever/courses/age_groups.json')
    stub_request(:get, 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?Page=1&RecordCount=1000&cmd=OptionsetAgeGroups').to_return(body: json_response)
  end

  def stub_course_templates
    json_response = File.new('spec/support/achiever/courses/templates.json')
    stub_request(:get, 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?HideFromweb=0&Page=1&ProgrammeName=ncce&RecordCount=1000&cmd=CourseTemplatesListingByProgramme').to_return(body: json_response)
  end
  
  def stub_delegate
    json_response = File.new('spec/support/achiever/courses/delegate.json')
    uri_template = Addressable::Template.new 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?CONTACTNO={contact_no}&Page=1&ProgrammeName=ncce&RecordCount=1000&cmd=CoursesForCurrentDelegateByProgramme'
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_face_to_face_occurrences
    json_response = File.new('spec/support/achiever/courses/face_to_face_occurrences.json')
    uri_template = Addressable::Template.new 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?Date={date}&EndDate={end_date}&ProgrammeName=ncce&Page=1&RecordCount=1000&cmd=CourseListingFutureByProgrammeId'
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_online_occurrences
    json_response = File.new('spec/support/achiever/courses/online_occurrences.json')
    uri_template = Addressable::Template.new 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?Date={date}&EndDate={end_date}&ProgrammeName=ncce&Page=1&RecordCount=1000&cmd=FutureOnlineCoursesByProgrammeId'
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_subjects
    json_response = File.new('spec/support/achiever/courses/subjects.json')
    stub_request(:get, 'https://stemapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=OptionsetSubject').to_return(body: json_response)
  end
end

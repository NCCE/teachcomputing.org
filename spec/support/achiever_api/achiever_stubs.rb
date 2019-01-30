module AchieverStubs
  def stub_fetch_future_courses
    raw_future_course_occurrences_xml = File.new('spec/support/achiever_api/future_course_occurrences.xml')
      stub_request(:get, ENV['ACHIEVER_API_ENDPOINT'])
        .with(query: hash_including({ "sXmlParams" => /SOME_FUTURE_COURSES_WORKFLOW_ID/ }))
        .to_return(raw_future_course_occurrences_xml)
  end

  def stub_approved_course_templates
    raw_future_course_templates_xml = File.new('spec/support/achiever_api/future_course_templates.xml')
    stub_request(:get, ENV['ACHIEVER_API_ENDPOINT'])
      .with(query: hash_including({ "sXmlParams" => /SOME_APPROVED_COURSE_TEMPLATES_WORKFLOW_ID/ }))
      .to_return(raw_future_course_templates_xml)
  end

  def stub_delegate_course_list
    raw_delegate_course_list_xml = File.new('spec/support/achiever_api/delegate_course_list.xml')
    stub_request(:get, ENV['ACHIEVER_API_ENDPOINT'])
      .with(query: hash_including({ "sXmlParams" => /SOME_COURSES_FOR_DELEGATE_WORKFLOW_ID/ }))
      .to_return(raw_delegate_course_list_xml)
  end
end

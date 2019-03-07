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

  def stub_course_template_subject_details
    raw_course_template_subject_details_xml = File.new('spec/support/achiever_api/course_template_subject_details.xml')
    raw_course_template_subject_details_alt_xml = File.new('spec/support/achiever_api/course_template_subject_details_alt.xml')
    stub_request(:get, ENV['ACHIEVER_API_ENDPOINT'])
      .with(query: hash_including({ "sXmlParams" => /SOME_APPROVED_COURSE_TEMPLATE_SUBJECT_DETAILS_WORKFLOW_ID/ }))
      .to_return(raw_course_template_subject_details_xml).times(4).then
      .to_return(raw_course_template_subject_details_alt_xml)
  end

  def stub_course_template_age_range
    raw_course_template_age_range_xml = File.new('spec/support/achiever_api/course_template_age_range.xml')
    raw_course_template_age_range_alt_xml = File.new('spec/support/achiever_api/course_template_age_range_alt.xml')
    stub_request(:get, ENV['ACHIEVER_API_ENDPOINT'])
      .with(query: hash_including({ "sXmlParams" => /SOME_APPROVED_COURSE_TEMPLATE_AGE_RANGE_WORKFLOW_ID/ }))
      .to_return(File.new('spec/support/achiever_api/course_template_age_range.xml')).times(2).then
      .to_return(File.new('spec/support/achiever_api/course_template_age_range_alt.xml')).times(2).then
      .to_return(File.new('spec/support/achiever_api/course_template_age_range.xml')).times(2).then
      .to_return(File.new('spec/support/achiever_api/course_template_age_range_alt.xml'))
  end
end

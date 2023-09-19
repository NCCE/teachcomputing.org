module AchieverStubs
  def stub_a_failed_response(method, query)
    json_response = File.new('spec/support/achiever/failure.json')
    query_strings = query.map { |k, v| "#{k}=#{v}" }.join('&')
    stub_request(:any,
                 "https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=#{method}&#{query_strings}").to_return(body: json_response)
  end

  def stub_an_html_error_page(method, query)
    json_response = File.new('spec/support/achiever/failure.html')
    query_strings = query.map { |k, v| "#{k}=#{v}" }.join('&')
    stub_request(:any,
                 "https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=#{method}&#{query_strings}").to_return(body: json_response)
  end

  def stub_age_groups
    json_response = File.new('spec/support/achiever/courses/age_groups.json')
    stub_request(:get,
                 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?Page=1&RecordCount=1000&cmd=OptionsetAgeGroups').to_return(body: json_response)
  end

  def stub_course_templates
    json_response = File.new('spec/support/achiever/courses/templates.json')
    stub_request(:get,
                 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?HideFromweb=0&Page=1&ProgrammeName=ncce&RecordCount=1000&cmd=CourseTemplatesListingByProgramme').to_return(body: json_response)
    json_response = %{
      {
        "GetJsonResult": {
          "EntityName": "sic_eventtemplate",
          "FailureReason": "",
          "Counter": 0,
          "MoreRecords": false,
          "OptionSetName": null,
          "Success": true,
          "OptionSetsClean": null,
          "OptionSets": null,
          "Entities": []
        }
      }
    }

    stub_request(:get,
                 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?HideFromweb=0&Page=1&ProgrammeName=PDLP&RecordCount=1000&cmd=CourseTemplatesListingByProgramme').to_return(body: json_response)
  end

  def stub_delegate
    json_response = File.new('spec/support/achiever/courses/delegate.json')
    uri_template = Addressable::Template.new 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?CONTACTNO={contact_no}&Page=1&ProgrammeName=ncce&RecordCount=1000&cmd=CoursesForCurrentDelegateByProgramme'
    stub_request(:get, uri_template).to_return(body: json_response)

    json_response = %{
      {
        "GetJsonResult": {
          "EntityName": "si_eventdelegate",
          "FailureReason": "",
          "Counter": 1,
          "MoreRecords": false,
          "OptionSetName": null,
          "Success": true,
          "OptionSetsClean": null,
          "OptionSets": null,
          "Entities": []
        }
      }
    }
    uri_template = Addressable::Template.new 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?CONTACTNO={contact_no}&Page=1&ProgrammeName=PDLP&RecordCount=1000&cmd=CoursesForCurrentDelegateByProgramme'
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_duration_units
    json_response = File.new('spec/support/achiever/courses/duration_units.json')
    stub_request(:get,
                 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=OptionsetDurationUnit').to_return(body: json_response)
  end

  def stub_face_to_face_occurrences
    json_response = File.new('spec/support/achiever/courses/face_to_face_occurrences.json')
    uri_template = Addressable::Template.new "https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?Date={date}&EndDate={end_date}&Page=1&ProgrammeName=ncce&RecordCount=1000&cmd=#{ENV['ACHIEVER_F2F_METHOD']}"
    stub_request(:get, uri_template).to_return(body: json_response)

    uri_template = Addressable::Template.new "https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?Date={date}&EndDate={end_date}&Page=1&ProgrammeName=PDLP&RecordCount=1000&cmd=#{ENV['ACHIEVER_F2F_METHOD']}"
    json_response = %{
      {
        "GetJsonResult": {
          "EntityName": "si_event",
          "FailureReason": "",
          "Counter": 0,
          "MoreRecords": false,
          "OptionSetName": null,
          "Success": true,
          "OptionSetsClean": null,
          "OptionSets": null,
          "Entities": []
        }
      }
    }
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_online_occurrences
    json_response = File.new('spec/support/achiever/courses/online_occurrences.json')
    uri_template = Addressable::Template.new "https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?EndDate={end_date}&Page=1&ProgrammeName=ncce&RecordCount=1000&cmd=#{ENV['ACHIEVER_ONLINE_METHOD']}"
    stub_request(:get, uri_template).to_return(body: json_response)

    uri_template = Addressable::Template.new "https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?EndDate={end_date}&Page=1&ProgrammeName=PDLP&RecordCount=1000&cmd=#{ENV['ACHIEVER_ONLINE_METHOD']}"
    json_response = %{
      {
        "GetJsonResult": {
          "EntityName": "si_event",
          "FailureReason": "",
          "Counter": 0,
          "MoreRecords": false,
          "OptionSetName": null,
          "Success": true,
          "OptionSetsClean": null,
          "OptionSets": null,
          "Entities": []
        }
      }
    }
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_subjects
    json_response = File.new('spec/support/achiever/courses/subjects.json')
    stub_request(:get,
                 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?cmd=OptionsetSubject').to_return(body: json_response)
  end

  def stub_occurrence_details
    json_response = File.new('spec/support/achiever/courses/occurrence_details.json')
    uri_template = Addressable::Template.new 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?ID=1&Page=1&ProgrammeName=ncce&RecordCount=1000&cmd=CourseDetails'
    stub_request(:get, uri_template).to_return(body: json_response)

    json_response = %{
      {
        "GetJsonResult": {
          "EntityName": "si_event",
          "FailureReason": "",
          "Counter": 0,
          "MoreRecords": false,
          "OptionSetName": null,
          "Success": true,
          "OptionSetsClean": null,
          "OptionSets": null,
          "Entities": []
        }
      }
    }
    uri_template = Addressable::Template.new 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?ID=1&Page=1&ProgrammeName=PDLP&RecordCount=1000&cmd=CourseDetails'
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_post_enrolment
    json_response = File.new('spec/support/achiever/users/enrolment.json')
    stub_request(:post, 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Set?Cmd=CreateNCCECertificate')
      .to_return(body: json_response)
  end

  def stub_valid_contact_details
    json_response = File.new('spec/support/achiever/courses/contact_valid.json')
    uri_template = Addressable::Template.new 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?CONTACTNO=ca432eb9-9b34-46db-afbb-fbd1efa89e6b&Page=1&RecordCount=1000&cmd=ContactDetails'
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_invalid_contact_details
    json_response = File.new('spec/support/achiever/courses/contact_invalid.json')
    uri_template = Addressable::Template.new 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?CONTACTNO=ca432eb9-9b34-46db-afbb-fbd1efa89e6c&Page=1&RecordCount=1000&cmd=ContactDetails'
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_contact_no_org_details
    json_response = File.new('spec/support/achiever/courses/contact_no_org.json')
    uri_template = Addressable::Template.new 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?CONTACTNO=ca432eb9-9b34-46db-afbb-fbd1efa89e6c&Page=1&RecordCount=1000&cmd=ContactDetails'
    stub_request(:get, uri_template).to_return(body: json_response)
  end

  def stub_attendance_sets
    json_response = File.new('spec/support/achiever/courses/attendance.json')
    stub_request(:get,
                 'https://stemraspberrypiapi.dev3.smartmembership.net/smartconnector.smartconnector.svc/JSON/Get?Page=1&RecordCount=1000&cmd=OptionsetAttendanceStatus').to_return(body: json_response)
  end
end

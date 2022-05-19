class Achiever::Course::Template
  attr_accessor :activity_code,
                :age_groups,
                :booking_url,
                :course_leaders,
                :course_template_no,
                :duration_unit,
                :duration_value,
                :how_long_is_the_course,
                :how_will_you_learn,
                :meta_description,
                :occurrences,
                :online_cpd,
                :outcomes,
                :programmes,
                :remote_delivered_cpd,
                :subjects,
                :summary,
                :title,
                :topics_covered,
                :who_is_it_for,
                :workstream,
                :always_on

  RESOURCE_PATH = 'Get?cmd=CourseTemplatesListingByProgramme'.freeze
  QUERY_STRINGS = { Page: '1',
                    RecordCount: '1000',
                    HideFromweb: '0',
                    ProgrammeName: 'ncce' }.freeze

  def self.from_resource(resource, activities)
    new.tap do |t|
      t.activity_code = resource.send('Template.ActivityCode')
      t.age_groups = resource.send('Template.AgeGroups').split(';')
      t.booking_url = resource.send('Template.BookingURL')
      t.course_leaders = resource.send('Template.CourseLeaders')
      t.course_template_no = resource.send('Template.COURSETEMPLATENO')
      t.duration_unit = resource.send('Template.DurationUnit')
      t.duration_value = resource.send('Template.Duration')
      t.how_long_is_the_course = resource.send('Template.HowLongCourse')
      t.how_will_you_learn = resource.send('Template.HowYouWillLearn')
      t.meta_description = resource.send('Template.MetaDescription')
      t.occurrences = []
      t.online_cpd = ActiveRecord::Type::Boolean.new.deserialize(resource.send('Template.OnlineCPD').downcase)
      t.outcomes = resource.send('Template.Outcomes')
      t.programmes = resource.send('Template.TCProgrammeTag').split(',')
      t.remote_delivered_cpd = ActiveRecord::Type::Boolean.new.deserialize(resource.send('Template.RemoteDeliveredCPD')&.downcase)
      t.subjects = resource.send('Template.AdditionalSubjects').split(';')
      t.summary = resource.send('Template.Summary')
      t.title = resource.send('Template.TemplateTitle')
      t.topics_covered = resource.send('Template.TopicsCovered')
      t.who_is_it_for = resource.send('Template.WhoIsFor')
      t.workstream = resource.send('Template.Workstream')

      activity = activities.select { |activity| activity.stem_course_template_no == t.course_template_no }&.first
      t.always_on = activity&.always_on || false
    end
  end

  def with_occurrences
    occurrences = [
      Achiever::Course::Delegate.new(JSON.parse({
        "Activity.COURSEOCCURRENCENO": "28321a2a-1236-eb11-a813-000d3a86f6ce",
        "Activity.ActivityCode": "CD422",
        "Activity.ActivityTitle": "Fundamentals of computer networks - remote",
        "Activity.CurrencyID": "b07a2531-ab4d-e911-a8a8-002248005a98",
        "Activity.InstanceCode": "F01",
        "Delegate.Is_Fully_Attended": 'True',
        "Activity.StartDate": "15\/01\/2020 00:00:00",
        "Activity.EndDate": "16\/12\/2021 15:45:00",
        "Activity.ManuallyAssignedPathway": "",
        "Activity.ITKCPDType": "100000013",
        "Activity.Status": "157430001",
        "Activity.AdditionalInformation": "",
        "Activity.ImportedToITK": "False",
        "Activity.IsFree": "False",
        "Activity.Confirmed": "False",
        "Activity.OnlineCPD": "False",
        "Activity.RemoteDeliveredCPD": "True",
        "Activity.BookingURL": "",
        "Activity.BookingOptions": "157430000",
        "Activity.PlacesRemaining": "25",
        "Activity.PayLater": "True",
        "Activity.ePayment": "157430001",
        "Activity.ChangedDate": "04\/12\/2020 10:03:46",
        "Activity.Duration": "5",
        "Activity.DurationUnit": "157430002",
        "Activity.AgeGroups": "157430001;157430011",
        "Activity.AgeRange": "",
        "Activity.AdditionalSubjects": "100000012;157430003",
        "Activity.SubDelivererID": "9539669a-3cde-e911-a812-000d3a86d6ce",
        "Activity.SubDeliverer": "The Castle School - 136916  ",
        "Activity.Deliverer": "",
        "Activity.RegionID": "",
        "Activity.Region": "South West",
        "ActivityVenueAddress.OrganisationID": "5a3654c3-9f6a-ea11-a811-000d3a86d7a3",
        "ActivityVenueAddress.VenueCode": "",
        "ActivityVenueAddress.PostCode": "",
        "ActivityVenueAddress.City": "Remote Delivered CPD",
        "ActivityVenueAddress.Address.Line1": "MS Teams",
        "ActivityVenueAddress.Address.Line2": "",
        "ActivityVenueAddress.Address.Line3": "",
        "ActivityVenueAddress.ADDRESSNO": "597273c5-14f1-ea11-a815-000d3a86d545",
        "ActivityVenueAddress.VenueName": "Virtual",
        "Template.WorkstreamID": "53baea18-0dcf-e911-a812-000d3a86d6ce",
        "Template.Workstream": "CS Accelerator",
        "Template.COURSETEMPLATENO": "526b3a42-b688-ea11-a811-000d3a86d545",
        "Template.Market": "157430005",
        "Template.ProgrammeID": "2dbaea18-0dcf-e911-a812-000d3a86d6ce",
        "Template.Programme": "NCCE",
        "Template.Title": "Fundamentals of computer networks - remote",
        "Template.HideFromWeb": false,
        "Activity.HideFromWeb": "False",
        "Template.Subject": "157430003",
        "Template.Duration": 5,
        "Template.DurationUnit": "157430002",
        "Template.RemoteDeliveredCPD": true
      }.to_json, object_class: OpenStruct)),
      Achiever::Course::Delegate.new(JSON.parse({
        "Activity.COURSEOCCURRENCENO": "42be25d2-760c-ea11-a811-000d3a86d7a3",
        "Activity.ActivityCode": "CA203",
        "Delegate.Is_Fully_Attended": 'True',
        "Activity.ActivityTitle": "Python programming essentials for GCSE computer science",
        "Activity.CurrencyID": "b07a2531-ab4d-e911-a8a8-002248005a98",
        "Activity.InstanceCode": "C06",
        "Activity.StartDate": "15\/01\/2020 09:00:00",
        "Activity.EndDate": "03\/02\/2020 16:00:00",
        "Activity.ManuallyAssignedPathway": "",
        "Activity.ITKCPDType": "157430006",
        "Activity.Status": "157430001",
        "Activity.ImportedToITK": "True",
        "Activity.IsFree": "False",
        "Activity.Confirmed": "True",
        "Activity.OnlineCPD": "False",
        "Activity.RemoteDeliveredCPD": "False",
        "Activity.BookingURL": "",
        "Activity.BookingOptions": "",
        "Activity.PlacesRemaining": "19",
        "Activity.PayLater": "True",
        "Activity.ePayment": "",
        "Activity.ChangedDate": "14\/08\/2020 12:17:02",
        "Activity.Duration": "2",
        "Activity.DurationUnit": "157430000",
        "Activity.AgeGroups": "157430001;157430011",
        "Activity.AgeRange": "",
        "Activity.AdditionalSubjects": "100000019;157430003;157430006",
        "Activity.SubDelivererID": "e7afef6b-fb09-ea11-a811-000d3a86d716",
        "Activity.SubDeliverer": "Edge Hill University - 133828  ",
        "Activity.Deliverer": "",
        "Activity.RegionID": "",
        "Activity.Region": "Greater Manchester, Merseyside & Cheshire ",
        "ActivityVenueAddress.OrganisationID": "458d0c7f-f637-4b30-8063-85d56df40f24",
        "ActivityVenueAddress.VenueCode": "138123",
        "ActivityVenueAddress.PostCode": "M33 5BP",
        "ActivityVenueAddress.City": "Sale",
        "ActivityVenueAddress.Address.Line1": "Cecil Avenue",
        "ActivityVenueAddress.Address.Line2": "",
        "ActivityVenueAddress.Address.Line3": "",
        "ActivityVenueAddress.ADDRESSNO": "a6709041-a987-4d97-acfb-97194b4c90ae",
        "ActivityVenueAddress.VenueName": "Ashton-on-Mersey School",
        "Template.WorkstreamID": "53baea18-0dcf-e911-a812-000d3a86d6ce",
        "Template.Workstream": "CS Accelerator",
        "Template.COURSETEMPLATENO": "de08c1a9-3868-ea11-a811-000d3a86d7a3",
        "Template.Market": "157430005",
        "Template.ProgrammeID": "2dbaea18-0dcf-e911-a812-000d3a86d6ce",
        "Template.Programme": "NCCE",
        "Template.Title": "DO NOT USE Python programming essentials for GCSE computer science",
        "Template.HideFromWeb": true,
        "Activity.HideFromWeb": "False",
        "Template.Subject": "157430003",
        "Template.Duration": 2,
        "Template.DurationUnit": "157430000",
        "Template.RemoteDeliveredCPD": false
      }.to_json, object_class: OpenStruct))
    ]
    # occurrences = online_cpd ? Achiever::Course::Occurrence.online : Achiever::Course::Occurrence.face_to_face
    occurrences.select { |occurrence| occurrence.course_template_no == course_template_no }
  end

  def self.all
    activities ||= Activity.all
    json_response = File.new('spec/support/achiever/courses/templates.json').read
    templates = JSON.parse(json_response, object_class: OpenStruct).GetJsonResult.Entities
    # templates = Achiever::Request.resource(RESOURCE_PATH, QUERY_STRINGS)
    templates.map { |course| Achiever::Course::Template.from_resource(course, activities) }
  end

  def self.find_by_activity_code(activity_code)
    templates = all
    template = templates.find { |val| val.activity_code == activity_code.upcase }
    raise ActiveRecord::RecordNotFound unless template

    template
  end

  def self.find_many_by_activity_codes(activity_codes)
    all.select { |val| activity_codes.include?(val.activity_code) }
  end

  def self.without(course)
    Achiever::Course::Template.all.reject { |c| c.course_template_no == course.course_template_no }
  end

  def self.find_many_by_stem_course_template_nos(stem_course_template_nos)
    Achiever::Course::Template.all.select { |val| stem_course_template_nos.include?(val.course_template_no) }
  end

  def by_certificate(certificate)
    case certificate
    when 'cs-accelerator'
      @programmes.include?('CS Accelerator')
    when 'secondary-certificate'
      @programmes.include?('Secondary')
    when 'primary-certificate'
      @programmes.include?('Primary')
    end
  end

  def duration
    Achiever::Course::DurationUnit.look_up(duration_unit.to_i)
  end

  def nearest_occurrence_distance
    occurrences.map(&:distance).compact.min
  end
end

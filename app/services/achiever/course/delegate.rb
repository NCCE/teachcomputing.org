class Achiever::Course::Delegate
  attr_accessor :course_occurence_no, :course_template_no, :is_fully_attended, :online_cpd, :progress, :address_venue_name, :address_venue_code, :address_town, :address_postcode, :address_line_one, :start_date, :end_date

  RESOURCE_PATH = 'Get?cmd=CoursesForCurrentDelegateByProgramme'.freeze
  PROGRAMME_NAME = 'ncce'.freeze
  CACHE = false

  def self.find_by_achiever_contact_number(achiever_contact_no)
    query_strings = {
      Page: '1',
      RecordCount: '1000',
      ProgrammeName: PROGRAMME_NAME,
      CONTACTNO: achiever_contact_no
    }
    # delegate_courses = Achiever::Request.resource(RESOURCE_PATH, query_strings, CACHE)
    # START HACK...
    delegate_courses = [
      JSON.parse({
        'Productlines.COURSEOCCURRENCENO': 'cf8903f9-91a2-4d08-ba41-596ea05b498c',
        'Productlines.PRODLINENO': '7f7751ef-ffbf-4d2e-ba36-dfa359371b1b',
        'Activity.ActivityTitle': 'Scratch course',
        ENQUIRYNO: '068178a1-b069-4f61-a2fc-857ef6f3a931',
        'Productlines.Type': '157420000',
        'Delegate.BookerFirstName': '',
        'Delegate.BookerSurname': '',
        'Delegate.Is_Fully_Attended': 'True',
        'ActivityVenueAddress.PostCode': '',
        'ActivityVenueAddress.City': 'Nodnol',
        'ActivityVenueAddress.Address.Line1': 'A place',
        'ActivityVenueAddress.ADDRESSNO': '8ca5e149-111e-4c59-9f69-c5d175bd80c6',
        'ActivityVenueAddress.VenueName': 'The centre of somewhere',
        'Activity.StartDate': "10\/07\/2019 00:00:00",
        'Activity.EndDate': "17\/07\/2019 00:00:00",
        'Delegate.FirstName': '',
        'Delegate.CalculatedSurname': '',
        'Delegate.CalculatedEmailAddress': 'user2@example.com',
        'Delegate.Progress': '157420003',
        'Activity.ImportedToITK': false,
        'Activity.COURSEOCCURRENCENO': 'cf8903f9-91a2-4d08-ba41-596ea05b498c',
        OnlineCPD: true,
        'Activity.COURSETEMPLATENO': '526b3a42-b688-ea11-a811-000d3a86d545'
      }.to_json, object_class: OpenStruct),
      JSON.parse({
        'Productlines.COURSEOCCURRENCENO': 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
        'Productlines.PRODLINENO': '7f7751ef-ffbf-4d2e-ba36-dfa359371b1b',
        'Activity.ActivityTitle': 'Python course',
        ENQUIRYNO: '068178a1-b069-4f61-a2fc-857ef6f3a931',
        'Productlines.Type': '157420000',
        'Delegate.BookerFirstName': '',
        'Delegate.BookerSurname': '',
        'Delegate.Is_Fully_Attended': 'False',
        'ActivityVenueAddress.PostCode': '',
        'ActivityVenueAddress.City': '',
        'ActivityVenueAddress.Address.Line1': 'Another place',
        'ActivityVenueAddress.Address.Line2': 'Somewhere else',
        'ActivityVenueAddress.Address.Line3': 'Even Far away',
        'ActivityVenueAddress.ADDRESSNO': '8ca5e149-111e-4c59-9f69-c5d175bd80c6',
        'ActivityVenueAddress.VenueName': '',
        'Activity.StartDate': "10\/07\/2019 00:00:00",
        'Activity.EndDate': "17\/07\/2019 00:00:00",
        'Delegate.FirstName': '',
        'Delegate.CalculatedSurname': '',
        'Delegate.CalculatedEmailAddress': 'user1@example.com',
        'Delegate.Progress': '157420003',
        'Activity.ImportedToITK': false,
        'Activity.COURSEOCCURRENCENO': 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
        OnlineCPD: false,
        'Activity.COURSETEMPLATENO': '17d78590-4268-ea11-a811-000d3a86d7a3'
      }.to_json, object_class: OpenStruct)
    ]
    # ...END HACK
    delegate_courses.map { |delegate_course| Achiever::Course::Delegate.new(delegate_course) }
  end

  def initialize(delegate_course)
    @course_occurence_no = delegate_course.send('Activity.COURSEOCCURRENCENO')
    @course_template_no = delegate_course.send('Activity.COURSETEMPLATENO')
    @is_fully_attended = ActiveRecord::Type::Boolean.new.deserialize(delegate_course.send('Delegate.Is_Fully_Attended').downcase)
    @online_cpd = delegate_course.send('OnlineCPD')
    @progress = delegate_course.send('Delegate.Progress')
    @address_venue_name = delegate_course.send('ActivityVenueAddress.VenueName')
    @address_venue_code = delegate_course.send('ActivityVenueAddress.VenueCode')
    @address_town = delegate_course.send('ActivityVenueAddress.City')
    @address_postcode = delegate_course.send('ActivityVenueAddress.PostCode')
    @address_line_one = delegate_course.send('ActivityVenueAddress.Address.Line1')
    @start_date = delegate_course.send('Activity.StartDate')
    @end_date = delegate_course.send('Activity.EndDate')
  end

  def attendance_status
    return 'attended' if @is_fully_attended

    Achiever::Course::Attendance.all.key(@progress.to_i)
  end
end

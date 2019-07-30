class Achiever::Course::Occurrence
  attr_accessor :activity_title,
                :age_groups,
                :subject,
                :booking_url,
                :start_date,
                :end_date,
                :activity_code,
                :region,
                :address_venue_name,
                :address_venue_code,
                :address_town,
                :address_postcode,
                :address_line_one,
                :course_template_no,
                :course_occurrence_no

  FACE_TO_FACE_RESOURCE_PATH = 'Get?cmd=CourseListingFutureByProgrammeId'.freeze
  ONLINE_RESOURCE_PATH = 'Get?cmd=FutureOnlineCoursesByProgrammeId'.freeze
  QUERY_STRINGS = { 'Page': '1',
                    'RecordCount': '1000',
                    'Date': '2019-01-01',
                    'ID': ENV.fetch('ACHIEVER_V2_NCCE_PROGRAMME_ID') }.freeze
  
  def self.face_to_face
    occurrences = Achiever::Request.resource(FACE_TO_FACE_RESOURCE_PATH, QUERY_STRINGS)
    occurrences.map { |occurrence| Achiever::Course::Occurrence.new(occurrence) }
  end

  def self.online
    occurrences = Achiever::Request.resource(ONLINE_RESOURCE_PATH, QUERY_STRINGS)
    occurrences.map { |occurrence| Achiever::Course::Occurrence.new(occurrence) }
  end

  def initialize(occurrence)
    @activity_title = occurrence.send('Activity.ActivityTitle')
    @age_groups = occurrence.send('Activity.AgeGroups').split(';')
    @subject = occurrence.send('Template.Subject')
    @booking_url = occurrence.send('Activity.BookingURL')
    @start_date = occurrence.send('Activity.StartDate')
    @end_date = occurrence.send('Activity.EndDate')
    @activity_code = occurrence.send('Activity.InstanceCode')
    @region = occurrence.send('Activity.Region')
    @address_venue_name = occurrence.send('ActivityVenueAddress.VenueName')
    @address_venue_code = occurrence.send('ActivityVenueAddress.VenueCode')
    @address_town = occurrence.send('ActivityVenueAddress.City')
    @address_postcode = occurrence.send('ActivityVenueAddress.PostCode')
    @address_line_one = occurrence.send('ActivityVenueAddress.Address.Line1')
    @course_template_no = occurrence.send('Activity.COURSETEMPLATENO')
    @course_occurrence_no = occurrence.send('Template.COURSEOCCURRENCENO')
  end
end

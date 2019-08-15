class Achiever::Course::Occurrence
  attr_accessor :activity_code,
                :activity_title,
                :address_venue_name,
                :address_venue_code,
                :address_town,
                :address_postcode,
                :address_line_one,
                :age_groups,
                :booking_url,
                :course_template_no,
                :course_occurrence_no,
                :end_date,
                :online_cpd,
                :region,
                :subject,
                :start_date

  FACE_TO_FACE_RESOURCE_PATH = 'Get?cmd=CourseListingFutureByProgrammeId'.freeze
  ONLINE_RESOURCE_PATH = 'Get?cmd=FutureOnlineCoursesByProgrammeId'.freeze
  QUERY_STRINGS = { 'Page': '1',
                    'RecordCount': '1000',
                    'Date': Time.zone.today.strftime('%F'),
                    'ID': ENV.fetch('ACHIEVER_V2_NCCE_PROGRAMME_ID') }.freeze

  def self.face_to_face
    occurrences = Achiever::Request.resource(FACE_TO_FACE_RESOURCE_PATH, QUERY_STRINGS)
    occurrences.map { |occurrence| Achiever::Course::Occurrence.new(occurrence) }
  end

  def self.online
    occurrences = Achiever::Request.resource(ONLINE_RESOURCE_PATH, QUERY_STRINGS.merge('EndDate': Time.zone.today.strftime('%F')))
    occurrences.map { |occurrence| Achiever::Course::Occurrence.new(occurrence) }
  end

  def initialize(occurrence)
    @activity_code = occurrence.send('Activity.InstanceCode')
    @activity_title = occurrence.send('Activity.ActivityTitle')
    @address_venue_name = occurrence.send('ActivityVenueAddress.VenueName')
    @address_venue_code = occurrence.send('ActivityVenueAddress.VenueCode')
    @address_town = occurrence.send('ActivityVenueAddress.City')
    @address_postcode = occurrence.send('ActivityVenueAddress.PostCode')
    @address_line_one = occurrence.send('ActivityVenueAddress.Address.Line1')
    @age_groups = occurrence.send('Activity.AgeGroups').split(';')
    @booking_url = occurrence.send('Activity.BookingURL')
    @course_template_no = occurrence.send('Template.COURSETEMPLATENO')
    @course_occurrence_no = occurrence.send('Template.COURSEOCCURRENCENO')
    @end_date = occurrence.send('Activity.EndDate')
    @online_cpd = ActiveRecord::Type::Boolean.new.deserialize(occurrence.send('Activity.OnlineCPD').downcase)
    @region = occurrence.send('Activity.Region')
    @subject = occurrence.send('Template.Subject')
    @start_date = occurrence.send('Activity.StartDate')
  end
end

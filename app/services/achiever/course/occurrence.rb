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
                :hub_id,
                :hub_name,
                :online_cpd,
                :region,
                :remote_delivered_cpd,
                :subject,
                :start_date

  FACE_TO_FACE_RESOURCE_PATH = 'Get?cmd=CourseListingFutureByProgrammeId'.freeze
  ONLINE_RESOURCE_PATH = 'Get?cmd=FutureOnlineCoursesByProgrammeId'.freeze
  QUERY_STRINGS = { 'Page': '1',
                    'RecordCount': '1000',
                    'EndDate': Time.zone.today.strftime('%F'),
                    'ProgrammeName': 'ncce' }.freeze

  def self.face_to_face
    occurrences = Achiever::Request.resource(FACE_TO_FACE_RESOURCE_PATH,
                                             QUERY_STRINGS.merge(Date: Time.zone.today.strftime('%F')))
    occurrences.map { |occurrence| Achiever::Course::Occurrence.from_resource(occurrence) }
  end

  def self.online
    occurrences = Achiever::Request.resource(ONLINE_RESOURCE_PATH, QUERY_STRINGS)
    occurrences.map { |occurrence| Achiever::Course::Occurrence.from_resource(occurrence) }
  end

  def self.from_resource(occurrence)
    new.tap do |o|
      o.activity_code = occurrence.send('Activity.InstanceCode')
      o.activity_title = occurrence.send('Activity.ActivityTitle')
      o.address_venue_name = occurrence.send('ActivityVenueAddress.VenueName')
      o.address_venue_code = occurrence.send('ActivityVenueAddress.VenueCode')
      o.address_town = occurrence.send('ActivityVenueAddress.City')
      o.address_postcode = occurrence.send('ActivityVenueAddress.PostCode')
      o.address_line_one = occurrence.send('ActivityVenueAddress.Address.Line1')
      o.age_groups = occurrence.send('Activity.AgeGroups').split(';')
      o.booking_url = occurrence.send('Activity.BookingURL')
      o.course_template_no = occurrence.send('Template.COURSETEMPLATENO')
      o.course_occurrence_no = occurrence.send('Activity.COURSEOCCURRENCENO')
      o.end_date = occurrence.send('Activity.EndDate')
      o.online_cpd = ActiveRecord::Type::Boolean.new.deserialize(occurrence.send('Activity.OnlineCPD').downcase)
      o.region = occurrence.send('Activity.Region')
      o.remote_delivered_cpd = ActiveRecord::Type::Boolean.new.deserialize(occurrence.send('Activity.RemoteDeliveredCPD')&.downcase)
      o.subject = occurrence.send('Template.Subject')
      o.start_date = occurrence.send('Activity.StartDate')
      o.hub_id = occurrence.send('Activity.SubDelivererID')
      o.hub_name = occurrence.send('Activity.SubDeliverer')
    end
  end
end

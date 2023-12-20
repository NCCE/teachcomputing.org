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
                :start_date,
                :coordinates,
                :distance

  FACE_TO_FACE_RESOURCE_PATH = "Get?cmd=#{ENV['ACHIEVER_F2F_METHOD']}".freeze
  ONLINE_RESOURCE_PATH = "Get?cmd=#{ENV['ACHIEVER_ONLINE_METHOD']}".freeze

  QUERY_STRINGS = { Page: '1',
                    RecordCount: '1000',
                    EndDate: Time.zone.today.strftime('%F') }.freeze
  PROGRAMME_NAMES = ['ncce', 'PDLP', 'Computing Clusters'].freeze

  def self.face_to_face(search_location_coordinates: nil)
    occurrences = PROGRAMME_NAMES.flat_map do |programme_name|
      Achiever::Request.resource(
        FACE_TO_FACE_RESOURCE_PATH,
        QUERY_STRINGS.merge(Date: Time.zone.today.strftime('%F'), ProgrammeName: programme_name)
      )
    end

    occurrences.map do |occurrence|
      Achiever::Course::Occurrence.from_resource(occurrence, comparison_coords: search_location_coordinates)
    end
  end

  def self.online
    occurrences = PROGRAMME_NAMES.flat_map do |programme_name|
      Achiever::Request.resource(
        ONLINE_RESOURCE_PATH,
        QUERY_STRINGS.merge(ProgrammeName: programme_name)
      )
    end

    occurrences.map { |occurrence| Achiever::Course::Occurrence.from_resource(occurrence) }
  end

  def self.from_resource(resource, comparison_coords: nil)
    occurrence = new.tap do |o|
      o.activity_code = resource.send('Activity.InstanceCode')
      o.activity_title = resource.send('Activity.ActivityTitle')
      o.address_venue_name = resource.send('ActivityVenueAddress.VenueName')
      o.address_venue_code = resource.send('ActivityVenueAddress.VenueCode')
      o.address_town = resource.send('ActivityVenueAddress.City')
      o.address_postcode = resource.send('ActivityVenueAddress.PostCode')
      o.address_line_one = resource.send('ActivityVenueAddress.Address.Line1')
      o.age_groups = resource.send('Activity.AgeGroups').split(';')
      o.booking_url = resource.send('Activity.BookingURL')
      o.course_template_no = resource.send('Template.COURSETEMPLATENO')
      o.course_occurrence_no = resource.send('Activity.COURSEOCCURRENCENO')
      o.end_date = resource.send('Activity.EndDate')
      o.online_cpd = ActiveRecord::Type::Boolean.new.deserialize(
        resource.send('Activity.OnlineCPD').downcase
      )
      o.region = resource.send('Activity.Region')
      o.remote_delivered_cpd = ActiveRecord::Type::Boolean.new.deserialize(
        resource.send('Activity.RemoteDeliveredCPD')&.downcase
      )
      o.subject = resource.send('Template.Subject')
      o.start_date = resource.send('Activity.StartDate')
      o.hub_id = resource.send('Activity.SubDelivererID')
      o.hub_name = resource.send('Activity.SubDeliverer')
    end

    lat = resource.send('ActivityVenueAddress.Latitude')
    long = resource.send('ActivityVenueAddress.Longitude')

    if lat.present? && long.present?
      occurrence.coordinates = [lat, long]

      if comparison_coords.present?
        occurrence.distance = Geocoder::Calculations
                              .distance_between(comparison_coords, occurrence.coordinates)
                              .round(1)
      end
    end
    occurrence
  end
end

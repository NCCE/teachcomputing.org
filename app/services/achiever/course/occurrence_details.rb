class Achiever::Course::OccurrenceDetails
  attr_accessor :activity_code,
                :activity_title,
                :address_city,
                :address_line_1,
                :address_line_2,
                :address_name,
                :address_post_code,
                :duration,
                :end_date,
                :id,
                :start_date,
                :summary,
                :title

  RESOURCE_PATH = 'Get?cmd=CourseDetails'.freeze

  def self.find(id)
    query_strings = {
      Page: '1',
      RecordCount: '1000',
      ID: id
    }
    occurrence_details = Achiever::Request.resource(RESOURCE_PATH, query_strings)
    Achiever::Course::OccurrenceDetails.new(occurrence_details.first)
  end

  def initialize(occurrence)
    @activity_code = occurrence.send('Activity.ActivityCode')
    @activity_title = occurrence.send('Activity.ActivityTitle')
    @address_city = occurrence.send('Venueaddress.City')
    @address_line_2 = occurrence.send('Venueaddress.Line1')
    @address_line_2 = occurrence.send('Venueaddress.Line2')
    @address_post_code = occurrence.send('Venueaddress.PostCode')
    @duration = occurrence.send('Template.Duration')
    @end_date = occurrence.send('Activity.EndDate')
    @id = occurrence.send('Activity.ID')
    @start_date = occurrence.send('Activity.StartDate')
    @summary = occurrence.send('Activity.Summary')
    @title = occurrence.send('Template.Title')
  end
end

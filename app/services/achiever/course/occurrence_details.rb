class Achiever::Course::OccurrenceDetails
  attr_accessor :id,
                :activity_code,
                :activity_title,
                :start_date,
                :end_date,
                :summary,
                :address_post_code,
                :address_city,
                :address_line_1,
                :address_line_2,
                :address_name,
                :title,
                :duration

  RESOURCE_PATH = 'Get?cmd=CourseDetails'.freeze
  PROGRAMME_NAME = 'ncce'.freeze

  def self.find(id)
    query_strings = {
      'Page': '1',
      'RecordCount': '1000',
      'ProgrammeName': PROGRAMME_NAME,
      'ID': id
    }
    occurrence_details = Achiever::Request.resource(RESOURCE_PATH, query_strings)
    Achiever::Course::OccurrenceDetails.new(occurrence_details.first)
  end

  def initialize(occurrence)
    @id = occurrence.send('Activity.ID')
    @activity_code = occurrence.send('Activity.ID')
    @activity_code = occurrence.send('Activity.ActivityCode')
    @activity_title = occurrence.send('Activity.ActivityTitle')
    @start_date = occurrence.send('Activity.StartDate')
    @end_date = occurrence.send('Activity.EndDate')
    @summary = occurrence.send('Activity.Summary')
    @address_post_code = occurrence.send('Venueaddress.PostCode')
    @address_city = occurrence.send('Venueaddress.City')
    @address_line_2 = occurrence.send('Venueaddress.Line1')
    @address_line_2 = occurrence.send('Venueaddress.Line2')
    @title = occurrence.send('Template.Title')
    @duration = occurrence.send('Template.Duration')
  end
end

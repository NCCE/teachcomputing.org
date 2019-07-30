class Achiever::Course::Template
  attr_accessor :course_template_no,
                :title,
                :summary,
                :booking_url,
                :activity_code,
                :meta_description,
                :activity_code,
                :subjects,
                :workstream,
                :occurrences

  RESOURCE_PATH = 'Get?cmd=CourseTemplatesListingByProgramme'.freeze
  QUERY_STRINGS = { 'Page': '1',
                    'RecordCount': '1000',
                    'ProgrammeID': ENV.fetch('ACHIEVER_V2_NCCE_PROGRAMME_ID') }.freeze

  def self.all
    templates = Achiever::Request.resource(RESOURCE_PATH, QUERY_STRINGS)
    templates.map { |course| Achiever::Course::Template.new(course) }
  end

  def initialize(template)
    @course_template_no = template.send('Template.COURSETEMPLATENO')
    @title = template.send('Template.TemplateTitle')
    @summary = template.send('Template.Summary')
    @booking_url = template.send('Template.Booking_URL')
    @meta_description = template.send('Template.MetaDescription')
    @activity_code = template.send('Template.ActivityCode')
    @subjects = template.send('Template.Subject').split(';')
    @workstream = template.send('Template.Workstream')
    @occurrences = []
  end
end

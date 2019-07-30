class Achiever::Course::Template
  attr_accessor :course_template_no,
                :summary,
                :activity_code,
                :meta_description,
                :activity_code,
                :subject,
                :workstream

  RESOURCE_PATH = 'Get?cmd=CourseTemplatesListing'.freeze
  QUERY_STRINGS = { 'Page': '1',
                    'RecordCount': '1000',
                    'ProgrammeID': env.fetch('ACHIEVER_V2_NCCE_PROGRAMME_ID') }.freeze

  def self.all
    templates = Achiever::Request.resource(RESOURCE_PATH, QUERY_STRINGS)
    templates.map { |course| Achiever::Template.new(course) }
  end

  def initialize(template)
    @course_template_no = template.send('Template.COURSETEMPLATENO')
    @summary = template.send('Template.Summary')
    @meta_description = template.send('Template.MetaDescription')
    @activity_code = template.send('Template.ActivityCode')
    @subject = template.send('Template.Subject').split(';')
    @workstream = template.send('Template.Workstream')
  end
end

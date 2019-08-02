class Achiever::Course::Template
  attr_accessor :course_template_no,
                :title,
                :summary,
                :booking_url,
                :activity_code,
                :meta_description,
                :activity_code,
                :workstream,
                :subjects,
                :online_cpd,
                :age_groups,
                :occurrences

  RESOURCE_PATH = 'Get?cmd=CourseTemplatesListingByProgramme'.freeze
  QUERY_STRINGS = { 'Page': '1',
                    'RecordCount': '1000',
                    'HideFromweb': '0',
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
    @workstream = template.send('Template.Workstream')
    @subjects = template.send('Template.AdditionalSubjects').split(';')
    @age_groups = template.send('Template.AgeGroups').split(';')
    @online_cpd = ActiveRecord::Type::Boolean.new.deserialize(template.send('Template.OnlineCPD').downcase)
    @occurrences = []
  end
end

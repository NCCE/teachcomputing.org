class Achiever::Course::Template
  attr_accessor :activity_code,
                :age_groups,
                :booking_url,
                :course_template_no,
                :duration,
                :meta_description,
                :occurrences,
                :online_cpd,
                :outcomes,
                :programmes,
                :remote_delivered_cpd,
                :subjects,
                :summary,
                :title,
                :workstream

  RESOURCE_PATH = 'Get?cmd=CourseTemplatesListingByProgramme'.freeze
  QUERY_STRINGS = { 'Page': '1',
                    'RecordCount': '1000',
                    'HideFromweb': '0',
                    'ProgrammeName': 'ncce' }.freeze

  def self.from_resource(template)
    new.tap do |t|
      t.activity_code = template.send('Template.ActivityCode')
      t.age_groups = template.send('Template.AgeGroups').split(';')
      t.booking_url = template.send('Template.BookingURL')
      t.course_template_no = template.send('Template.COURSETEMPLATENO')
      t.duration = template.send('Template.Duration')
      t.meta_description = template.send('Template.MetaDescription')
      t.occurrences = []
      t.online_cpd = ActiveRecord::Type::Boolean.new.deserialize(template.send('Template.OnlineCPD').downcase)
      t.outcomes = template.send('Template.Outcomes')
      t.programmes = template.send('Template.TCProgrammeTag').split(',')
      t.remote_delivered_cpd = ActiveRecord::Type::Boolean.new.deserialize(template.send('Template.RemoteDeliveredCPD')&.downcase)
      t.subjects = template.send('Template.AdditionalSubjects').split(';')
      t.summary = template.send('Template.Summary')
      t.title = template.send('Template.TemplateTitle')
      t.workstream = template.send('Template.Workstream')
    end
  end

  def with_occurrences
    occurrences = online_cpd ? Achiever::Course::Occurrence.online : Achiever::Course::Occurrence.face_to_face
    occurrences.select { |occurrence| occurrence.course_template_no == course_template_no }
  end

  def self.all
    templates = Achiever::Request.resource(RESOURCE_PATH, QUERY_STRINGS)
    templates.map { |course| Achiever::Course::Template.from_resource(course) }
  end

  def self.find_by_activity_code(activity_code)
    templates = all
    template = templates.find { |val| val.activity_code == activity_code.upcase }
    raise ActiveRecord::RecordNotFound unless template

    template
  end

  def self.without(course)
    Achiever::Course::Template.all.reject { |c| c.course_template_no == course.course_template_no }
  end

  def by_certificate(certificate)
    case certificate
    when 'cs-accelerator'
      @programmes.include?('CS Accelerator')
    when 'secondary-certificate'
      @programmes.include?('Secondary')
    when 'primary-certificate'
      @programmes.include?('Primary')
    end
  end
end

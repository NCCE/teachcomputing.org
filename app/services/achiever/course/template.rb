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
  QUERY_STRINGS = { Page: '1',
                    RecordCount: '1000',
                    HideFromweb: '0',
                    ProgrammeName: 'ncce' }.freeze

  def self.from_resource(resource)
    new.tap do |t|
      t.activity_code = resource.send('Template.ActivityCode')
      t.age_groups = resource.send('Template.AgeGroups').split(';')
      t.booking_url = resource.send('Template.BookingURL')
      t.course_template_no = resource.send('Template.COURSETEMPLATENO')
      t.duration = resource.send('Template.Duration')
      t.meta_description = resource.send('Template.MetaDescription')
      t.occurrences = []
      t.online_cpd = ActiveRecord::Type::Boolean.new.deserialize(resource.send('Template.OnlineCPD').downcase)
      t.outcomes = resource.send('Template.Outcomes')
      t.programmes = resource.send('Template.TCProgrammeTag').split(',')
      t.remote_delivered_cpd = ActiveRecord::Type::Boolean.new.deserialize(resource.send('Template.RemoteDeliveredCPD')&.downcase)
      t.subjects = resource.send('Template.AdditionalSubjects').split(';')
      t.summary = resource.send('Template.Summary')
      t.title = resource.send('Template.TemplateTitle')
      t.workstream = resource.send('Template.Workstream')
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

  def self.find_many_by_activity_codes(activity_codes)
    all.select { |val| activity_codes.include?(val.activity_code) }
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

  def nearest_occurrence_distance
    occurrences.map(&:distance).compact.min
  end
end

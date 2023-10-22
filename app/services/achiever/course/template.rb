class Achiever::Course::Template
  include ActionView::Helpers::TextHelper

  attr_accessor :activity_code,
                :age_groups,
                :booking_url,
                :course_leaders,
                :course_template_no,
                :duration_unit,
                :duration_value,
                :how_long_is_the_course,
                :how_will_you_learn,
                :meta_description,
                :occurrences,
                :online_cpd,
                :outcomes,
                :programmes,
                :remote_delivered_cpd,
                :subjects,
                :summary,
                :title,
                :topics_covered,
                :who_is_it_for,
                :workstream,
                :always_on

  RESOURCE_PATH = 'Get?cmd=CourseTemplatesListingByProgramme'.freeze
  QUERY_STRINGS = { Page: '1',
                    RecordCount: '1000',
                    HideFromweb: '0' }.freeze
  PROGRAMME_NAMES = %w[ncce PDLP].freeze

  def self.from_resource(resource, activities)
    new.tap do |t|
      t.activity_code = resource.send('Template.ActivityCode')
      t.age_groups = resource.send('Template.AgeGroups').split(';')
      t.booking_url = resource.send('Template.BookingURL')
      t.course_leaders = resource.send('Template.CourseLeaders')
      t.course_template_no = resource.send('Template.COURSETEMPLATENO')
      t.duration_unit = resource.send('Template.DurationUnit')
      t.duration_value = resource.send('Template.Duration')
      t.how_long_is_the_course = resource.send('Template.HowLongCourse')
      t.how_will_you_learn = resource.send('Template.HowYouWillLearn')
      t.meta_description = resource.send('Template.MetaDescription')
      t.occurrences = []
      t.online_cpd = ActiveRecord::Type::Boolean.new.deserialize(resource.send('Template.OnlineCPD').downcase)
      t.outcomes = resource.send('Template.Outcomes')
      t.programmes = resource.send('Template.TCProgrammeTag').split(',')
      t.remote_delivered_cpd = ActiveRecord::Type::Boolean.new.deserialize(resource.send('Template.RemoteDeliveredCPD')&.downcase)
      t.subjects = resource.send('Template.AdditionalSubjects').split(';')
      t.summary = resource.send('Template.Summary')
      t.title = resource.send('Template.TemplateTitle')
      t.topics_covered = resource.send('Template.TopicsCovered')
      t.who_is_it_for = resource.send('Template.WhoIsFor')
      t.workstream = resource.send('Template.Workstream')

      activity = activities.select { |activity| activity.stem_course_template_no == t.course_template_no }&.first
      t.always_on = activity&.always_on || false
    end
  end

  def with_occurrences
    occurrences = online_cpd ? Achiever::Course::Occurrence.online : Achiever::Course::Occurrence.face_to_face
    occurrences.select { |occurrence| occurrence.course_template_no == course_template_no }
  end

  def self.all
    activities ||= Activity.all
    templates = PROGRAMME_NAMES.flat_map do |programme_name|
      Achiever::Request.resource(RESOURCE_PATH, QUERY_STRINGS.merge(ProgrammeName: programme_name))
    end
    templates.map { |course| Achiever::Course::Template.from_resource(course, activities) }
  end

  # @return [Achiever::Course::Template] !!raises ActiveRecord::RecordNotFound!! if none . Use this method if you are using
  # untrusted data such as a URL path to show a page for a course, otherwise use #maybe_find_by_activity_code.
  def self.find_by_activity_code(activity_code)
    templates = all
    template = templates.find { |val| val.activity_code == activity_code.upcase }
    raise ActiveRecord::RecordNotFound, "Could not find template #{activity_code} in Smart Connector" unless template

    template
  end

  # @return [Achiever::Course::Template|nil] nil if not found. Silently logs and reports an error if not found, so use this method
  # if you know the course should exist (because you have a matching course Activity)
  def self.maybe_find_by_activity_code(activity_code)
    templates = all
    template = templates.find { |val| val.activity_code == activity_code.upcase }

    unless template
      message = "Could not find template #{activity_code} in Smart Connector"
      Rails.logger.error(message)
      Sentry.capture_message(message, level: :error)
    end

    template
  end

  def self.find_many_by_activity_codes(activity_codes)
    all.select { |val| activity_codes.include?(val.activity_code) }
  end

  def self.without(course)
    Achiever::Course::Template.all.reject { |c| c.course_template_no == course.course_template_no }
  end

  def self.find_many_by_stem_course_template_nos(stem_course_template_nos)
    Achiever::Course::Template.all.select { |val| stem_course_template_nos.include?(val.course_template_no) }
  end

  def by_certificate(certificate)
    case certificate
    when 'cs-accelerator'
      @programmes.include?('CS Accelerator')
    when 'secondary-certificate'
      @programmes.include?('Secondary')
    when 'primary-certificate'
      @programmes.include?('Primary')
    when 'i-belong'
      @programmes.include?('I Belong')
    when 'a-level-certificate'
      @programmes.include?('A Level')
    end
  end

  def duration
    Achiever::Course::DurationUnit.look_up(duration_unit.to_i)
  end

  def nearest_occurrence_distance
    occurrences.map(&:distance).compact.min
  end

  def duration_present?
    duration_unit.present? && duration_value.present?
  end

  # For example, "8 hours" or "1 week"
  def formatted_duration
    return '' unless duration_present?

    pluralize(duration_value, duration.downcase.chomp('s'))
  end
end

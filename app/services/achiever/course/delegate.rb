class Achiever::Course::Delegate
  attr_accessor :course_template_no, :is_fully_attended, :online_cpd, :progress

  RESOURCE_PATH = 'Get?cmd=CoursesForCurrentDelegateByProgramme'.freeze
  PROGRAMME_NAME = 'ncce'.freeze
  CACHE = false.freeze

  def self.find_by_achiever_contact_number(achiever_contact_no)
    query_strings = {
      'Page': '1',
      'RecordCount': '1000',
      'ProgrammeName': PROGRAMME_NAME,
      'CONTACTNO': achiever_contact_no
    }
    delegate_courses = Achiever::Request.resource(RESOURCE_PATH, query_strings, cache = CACHE)
    delegate_courses.map { |delegate_course| Achiever::Course::Delegate.new(delegate_course) }
  end

  def initialize(delegate_course)
    @course_template_no = delegate_course.send('Activity.COURSETEMPLATENO')
    @is_fully_attended = ActiveRecord::Type::Boolean.new.deserialize(delegate_course.send('Delegate.Is_Fully_Attended').downcase)
    @online_cpd = delegate_course.send('OnlineCPD')
    @progress = delegate_course.send('Delegate.Progress')
  end

  def attendance_status
    return 'attended' if @is_fully_attended

    Achiever::Course::Attendance.all.key(@progress.to_i)
  end
end

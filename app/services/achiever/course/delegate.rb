class Achiever::Course::Delegate
  attr_accessor :course_template_no, :is_fully_attended

  RESOURCE_PATH = 'Get?cmd=CoursesForCurrentDelegateByProgramme'.freeze
  PROGAMME_ID = ENV.fetch('ACHIEVER_V2_NCCE_PROGRAMME_ID').freeze

  def self.find_by_achiever_contact_number(achiever_contact_no)
    query_strings = {
      'Page': '1',
      'RecordCount': '1000',
      'ProgrammeID': PROGAMME_ID,
      'CONTACTNO': achiever_contact_no
    }
    delegate_courses = Achiever::Request.resource(RESOURCE_PATH, query_strings)
    delegate_courses.map { |delegate_course| Achiever::Course::Delegate.new(delegate_course) }
  end

  def initialize(delegate_course)
    @course_template_no = delegate_course.send('Activity.COURSETEMPLATENO')
    @is_fully_attended = ActiveRecord::Type::Boolean.new.deserialize(delegate_course.send('Delegate.Is_Fully_Attended').downcase)
  end
end

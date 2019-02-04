require_relative('achiever')

class DelegateCourseList
  def self.from_achiever(contact_no)
    achiever = Achiever.new
    results = achiever.courses_for_delegates(contact_no)
    results.map { |delegate| DelegateCourse.new(delegate) }
  end
end

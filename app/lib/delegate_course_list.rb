require_relative('achiever')

class DelegateCourseList
  def self.from_achiever(contact_no)
    bookings = []
    achiever = Achiever.new
    results = achiever.fetch_courses_for_delegates(contact_no)

    results.each do |result|
      bookings << DelegateCourse.new(result)
    end
    bookings
  end
end

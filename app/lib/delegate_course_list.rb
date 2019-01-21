require_relative('achiever')

class DelegateCourseList
  def self.fromAchiever(contactNo)
    bookings = Array.new
    achiever = Achiever.new
    results = achiever.fetchCoursesForDelegates(contactNo)

    results.each do |result|
      bookings << DelegateCourse.new(result)
    end
    bookings
  end
end

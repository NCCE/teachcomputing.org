require('nokogiri')
require_relative('./achiever')
require_relative('./course_occurrence_fee')

class CourseOccurrenceFeeArray < Array
  def fetchCourseOccurrenceFees(id)
    achiever = Achiever.new
    fees = achiever.fetchCourseOccurrenceFees(id)
    fees.each do |fee|
      self << CourseOccurrenceFee.new(fee)
    end
  end
end

class Achiever::Course::Delegate
  attr_accessor :course_occurence_no, :course_template_no, :is_fully_attended, :online_cpd, :progress, :address_venue_name, :address_venue_code, :address_town, :address_postcode, :address_line_one, :start_date, :end_date

  RESOURCE_PATH = "Get?cmd=CoursesForCurrentDelegateByProgramme".freeze
  PROGRAMME_NAMES = %w[ncce PDLP].freeze
  CACHE = false

  def self.find_by_achiever_contact_number(achiever_contact_no)
    delegate_courses = PROGRAMME_NAMES.flat_map do |programme_name|
      query_strings = {
        Page: "1",
        RecordCount: "1000",
        ProgrammeName: programme_name,
        CONTACTNO: achiever_contact_no
      }

      delegate_courses = Achiever::Request.resource(RESOURCE_PATH, query_strings, CACHE)
    end
    delegate_courses.map { |delegate_course| Achiever::Course::Delegate.new(delegate_course) }
  end

  def initialize(delegate_course)
    @course_occurence_no = delegate_course.send(:"Activity.COURSEOCCURRENCENO")
    @course_template_no = delegate_course.send(:"Activity.COURSETEMPLATENO")
    @is_fully_attended = ActiveRecord::Type::Boolean.new.deserialize(delegate_course.send(:"Delegate.Is_Fully_Attended").downcase)
    @online_cpd = delegate_course.send(:OnlineCPD)
    @progress = delegate_course.send(:"Delegate.Progress")
    @address_venue_name = delegate_course.send(:"ActivityVenueAddress.VenueName")
    @address_venue_code = delegate_course.send(:"ActivityVenueAddress.VenueCode")
    @address_town = delegate_course.send(:"ActivityVenueAddress.City")
    @address_postcode = delegate_course.send(:"ActivityVenueAddress.PostCode")
    @address_line_one = delegate_course.send(:"ActivityVenueAddress.Address.Line1")
    @start_date = delegate_course.send(:"Activity.StartDate")
    @end_date = delegate_course.send(:"Activity.EndDate")
  end

  def attendance_status
    return "attended" if @is_fully_attended

    Achiever::Course::Attendance.all.key(@progress.to_i)
  end
end

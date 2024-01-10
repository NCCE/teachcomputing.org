class Achiever::Course::Attendance
  RESOURCE_PATH = "Get?cmd=OptionsetAttendanceStatus".freeze
  QUERY_STRINGS = {Page: "1",
                   RecordCount: "1000"}.freeze

  def self.all
    options = Achiever::Request.option_sets(RESOURCE_PATH, QUERY_STRINGS)
    JSON.parse(options).reduce({}, :merge).transform_keys(&:downcase)
  end
end

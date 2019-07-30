class Achiever::Course::Subject
  RESOURCE_PATH = 'Get?cmd=OptionsetSubject'.freeze

  def self.all
    subjects = Achiever::Request.option_sets(RESOURCE_PATH)
    parsed_response = JSON.parse(subjects)
    parsed_response.reduce({}, :merge)
  end
end

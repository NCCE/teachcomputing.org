class Achiever::Course::Subject
  RESOURCE_PATH = "Get?cmd=OptionsetSubject".freeze

  def self.all
    subjects = Achiever::Request.option_sets(RESOURCE_PATH)
    JSON.parse(subjects).reduce({}, :merge)
  end
end

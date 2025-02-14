class Achiever::Course::DurationUnit
  RESOURCE_PATH = "Get?cmd=OptionsetDurationUnit".freeze

  def self.all
    duration_units = Achiever::Request.option_sets(RESOURCE_PATH)
    JSON.parse(duration_units)
  end

  def self.look_up(id)
    duration_units = Achiever::Course::DurationUnit.all
    matched = duration_units.find { |duration| duration.has_value?(id) }
    return unless matched

    matched.keys.first
  end
end

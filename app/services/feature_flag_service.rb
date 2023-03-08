# a list of flags that are each enabled by setting them to 'on' in the environment
#
# access with FeatureFlagService.new.flags[:flag_key]
#
# use extra flags added locally at run time with FeatureFlagService.new(flags: {new_flag1: 'FLAG_NEW_FLAG1'}).flags[:new_flag1]
#
class FeatureFlagService
  FLAGS = {
    ncce2: 'FLAG_NCCE2'
  }.freeze

  def initialize(dependencies = {})
    @flags_to_define = dependencies.fetch(:flags) do
      FLAGS
    end
  end

  def flags
    @flags ||= begin
      @flags_to_define.transform_values { |v| cast_boolean(ENV[v]) }
    end
  end

  # only true when ncce2 flag set, and NCCE2_START_DATE has past; this is a one-off flag that turns on automatically on a date
  # determined by the environment variable
  #
  # TODO: rm this method when remove ncce2 flag
  #
  # note: set NCCE2_START_DATE to 2nd April "2023-04-02T00:00:00+00:00" to allow the jobs to run a final time on 1st April and
  # pick up the last end of the month course completions.
  def ncce2_live
    start_date_string = ENV['NCCE2_START_DATE']
    return false unless start_date_string

    flags[:ncce2] && (Date.today >= Date.parse(start_date_string))
  end

  private

    def cast_boolean(string_value)
      string_value == 'on'
    end
end

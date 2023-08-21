# a list of flags that are each enabled by setting them to 'on' in the environment
#
# access with FeatureFlagService.new.flags[:flag_key]
#
# use extra flags added locally at run time with FeatureFlagService.new(flags: {new_flag1: 'FLAG_NEW_FLAG1'}).flags[:new_flag1]
#
class FeatureFlagService
  FLAGS = {
    # example_feature: 'FLAG_EXAMPLE_FEATURE'
    ibelong_programme_feature: 'FLAG_IBELONG_PROGRAMME',
    alevel_programme_feature: 'FLAG_ALEVEL_PROGRAMME'
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

  private

    def cast_boolean(string_value)
      string_value == 'on'
    end
end

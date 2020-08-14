class FeatureFlagService
  FLAGS = {
    fl_lti_enabled: 'FLAG_FL_LTI_ENABLED'
  }.freeze

  def initialize(dependencies = {})
    @flags_to_define = dependencies.fetch(:flags) do
      FLAGS
    end
  end

  def flags
    @flags ||= begin
                 @flags_to_define.map { |k, v| [k, cast_boolean(ENV[v])] }.to_h
               end
  end

  private

    def cast_boolean(string_value)
      return false unless string_value.present?

      ActiveModel::Type::Boolean.new.cast(string_value)
    end
end

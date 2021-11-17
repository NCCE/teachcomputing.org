class FeatureFlagService
  FLAGS = {
    primary_redesign_enabled: 'PRIMARY_REDESIGN_ENABLED'
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
      return false unless string_value.present?

      ActiveModel::Type::Boolean.new.cast(string_value)
    end
end

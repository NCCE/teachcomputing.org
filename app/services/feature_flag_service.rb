class FeatureFlagService
  class << self
    def flags
      @flags ||= {
        fl_lti_enabled: cast_boolean(ENV['FLAG_FL_LTI_ENABLED'])
      }
    end

    private

      def cast_boolean(string_value)
        ActiveModel::Type::Boolean.new.cast(string_value)
      end
  end
end

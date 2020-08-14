require 'rails_helper'

RSpec.describe FeatureFlagService do
  describe '.flags' do
    subject(:flags) { described_class.flags }

    it 'sets boolean values for flags' do
      expect(flags.values.all? { |x| [TrueClass, FalseClass].include?(x.class) })
        .to eq(true)
    end

    it 'sets the future learn lti flag' do
      expect(flags[:fl_lti_enabled]).not_to eq(nil)
    end
  end
end

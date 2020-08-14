require 'rails_helper'

RSpec.describe FeatureFlagService do
  describe '.flags' do
    subject(:flags) { described_class.new(flags: { test_flag: 'TEST_FLAG_VAR' }).flags }

    context('when env var is "true"') do
      before do
        ENV['TEST_FLAG_VAR'] = 'true'
      end

      it 'sets flag correctly' do
        expect(flags[:test_flag]).to eq(true)
      end
    end

    context('when env var is "false"') do
      before do
        ENV['TEST_FLAG_VAR'] = 'false'
      end

      it 'sets flag correctly' do
        expect(flags[:test_flag]).to eq(false)
      end
    end

    context('when env var is empty') do
      before do
        ENV['TEST_FLAG_VAR'] = ''
      end

      it 'sets flag correctly' do
        expect(flags[:test_flag]).to eq(false)
      end
    end

    context('when env var is not set') do
      it 'sets flag correctly' do
        expect(flags[:test_flag]).to eq(false)
      end
    end

    context('with app defined flags') do
      subject(:flags) { described_class.new.flags }

      it 'sets the future learn lti flag' do
        expect(flags[:fl_lti_enabled]).not_to eq(nil)
      end
    end
  end

  describe 'FLAGS' do
    it 'defines hash of flags correctly' do
      flag_hash = { fl_lti_enabled: 'FLAG_FL_LTI_ENABLED' }
      expect(FeatureFlagService::FLAGS).to eq(flag_hash)
    end
  end
end

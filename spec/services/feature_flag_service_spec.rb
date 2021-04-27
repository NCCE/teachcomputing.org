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
      before do
        ENV['TEST_FLAG_VAR'] = nil
      end

      it 'sets flag correctly' do
        expect(flags[:test_flag]).to eq(false)
      end
    end
  end

  describe 'FLAGS' do
    it 'defines hash of flags correctly' do
      expect(FeatureFlagService::FLAGS.count).to eq 2
    end

    it 'sets the csa_questionnaire_enabled flag' do
      expect(FeatureFlagService::FLAGS.keys).to include(:csa_questionnaire_enabled)
    end

    it 'sets the badges_enabled flag' do
      expect(FeatureFlagService::FLAGS.keys).to include(:badges_enabled)
    end
  end
end

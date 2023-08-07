require 'rails_helper'

RSpec.describe FeatureFlagService do
  around do |example|
    orig_test_flag_var = ENV['TEST_FLAG_VAR']
    example.run
  ensure
    ENV['TEST_FLAG_VAR'] = orig_test_flag_var
  end

  describe '#flags' do
    subject(:flags) { described_class.new(flags: { test_flag: 'TEST_FLAG_VAR' }).flags }

    context('when env var is "on"') do
      before do
        ENV['TEST_FLAG_VAR'] = 'on'
      end

      it 'sets flag correctly' do
        expect(flags[:test_flag]).to be true
      end
    end

    context('when env var is "off"') do
      before do
        ENV['TEST_FLAG_VAR'] = 'off'
      end

      it 'sets flag correctly' do
        expect(flags[:test_flag]).to be false
      end
    end

    context('when env var is empty') do
      before do
        ENV['TEST_FLAG_VAR'] = ''
      end

      it 'sets flag correctly' do
        expect(flags[:test_flag]).to be false
      end
    end

    context('when env var is not set') do
      before do
        ENV['TEST_FLAG_VAR'] = nil
      end

      it 'sets flag correctly' do
        expect(flags[:test_flag]).to be false
      end
    end
  end

  describe 'FLAGS' do
    it 'defines hash of flags correctly' do
      expect(FeatureFlagService::FLAGS.count).to eq 1
    end
  end
end

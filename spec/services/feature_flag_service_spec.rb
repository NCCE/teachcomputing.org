require 'rails_helper'

RSpec.describe FeatureFlagService do
  around do |example|
    orig_test_flag_var = ENV['TEST_FLAG_VAR']
    orig_flag_ncce2 = ENV['FLAG_NCCE2']
    orig_flag_ncce2_start_date = ENV['NCCE2_START_DATE']
    example.run
  ensure
    ENV['TEST_FLAG_VAR'] = orig_test_flag_var
    ENV['FLAG_NCCE2'] = orig_flag_ncce2
    ENV['NCCE2_START_DATE'] = orig_flag_ncce2_start_date
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

  describe '#ncce2_live' do
    it 'is true when flag set on start date' do
      ENV['NCCE2_START_DATE'] = '2023-04-02'
      ENV['FLAG_NCCE2'] = 'on'
      Timecop.freeze(2023, 4, 2) do
        expect(described_class.new.ncce2_live).to be true
      end
    end

    it 'is false when flag unset' do
      ENV['FLAG_NCCE2'] = nil
      expect(described_class.new.ncce2_live).to be false
    end

    it 'is false when flag set before start date' do
      ENV['NCCE2_START_DATE'] = '2023-04-02'
      ENV['FLAG_NCCE2'] = 'on'
      Timecop.freeze(2023, 4, 1, 23, 59) do
        expect(described_class.new.ncce2_live).to be false
      end
    end

    it 'is false when flag unset on start date' do
      ENV['NCCE2_START_DATE'] = '2023-04-02'
      ENV['FLAG_NCCE2'] = nil
      Timecop.freeze(2023, 4, 2) do
        expect(described_class.new.ncce2_live).to be false
      end
    end

    it 'is false when start date unset' do
      ENV['NCCE2_START_DATE'] = nil
      expect(described_class.new.ncce2_live).to be false
    end
  end
end

require 'rails_helper'

RSpec.describe Achiever::Course::AgeGroup do
  describe 'constants' do
    describe 'RESOURCE_PATH' do
      it 'is not nil' do
        expect(Achiever::Course::AgeGroup::RESOURCE_PATH).not_to eq nil
      end
    end

    describe 'QUERY_STRINGS' do
      it 'contains page' do
        expect(Achiever::Course::AgeGroup::QUERY_STRINGS).to have_key(:Page)
      end

      it 'contains record count' do
        expect(Achiever::Course::AgeGroup::QUERY_STRINGS).to have_key(:RecordCount)
      end
    end
  end

  describe 'class methods' do
    before do
      stub_age_groups
    end

    describe '#all' do
      it 'returns an Array' do
        expect(described_class.all).to be_an Hash
      end

      it 'only contains items that start with the word key' do
        described_class.all.each do |age_group|
          expect(age_group.first).to start_with('Key').or eq('Post 16')
        end
      end
    end

    describe '#primary_certificate' do
      it 'contains two values' do
        expect(described_class.primary_certificate.count).to eq 2
      end

      it 'does not include secondary certificate values' do
        expect(described_class.primary_certificate).not_to include described_class.secondary_certificate
      end
    end

    describe '#secondary_certificate' do
      it 'contains two values' do
        expect(described_class.secondary_certificate.count).to eq 2
      end

      it 'does not include primary certificate values' do
        expect(described_class.secondary_certificate).not_to include described_class.primary_certificate
      end
    end
  end
end

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
    describe '#all' do
      before do
        stub_age_groups
      end

      it 'returns an Array' do
        expect(described_class.all).to be_an Hash
      end

      it 'only contains items that start with the word key' do
        described_class.all.each do |age_group|
          expect(age_group.first).to start_with('Key')
        end
      end
    end
  end
end

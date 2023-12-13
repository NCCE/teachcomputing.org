require 'rails_helper'

RSpec.describe Achiever::Course::OccurrenceDetails do
  let(:occurrence_details) { described_class.find('1') }

  describe 'accessor methods' do
    before do
      stub_occurrence_details
    end

    it 'provides the required accessor methods' do
      expect(occurrence_details).to respond_to(:id)
      expect(occurrence_details).to respond_to(:activity_code)
      expect(occurrence_details).to respond_to(:activity_title)
      expect(occurrence_details).to respond_to(:start_date)
      expect(occurrence_details).to respond_to(:end_date)
      expect(occurrence_details).to respond_to(:summary)
      expect(occurrence_details).to respond_to(:address_post_code)
      expect(occurrence_details).to respond_to(:address_city)
      expect(occurrence_details).to respond_to(:address_line_1)
      expect(occurrence_details).to respond_to(:address_line_2)
      expect(occurrence_details).to respond_to(:address_name)
      expect(occurrence_details).to respond_to(:title)
      expect(occurrence_details).to respond_to(:duration)
    end
  end

  describe 'constants' do
    describe 'ONLINE_RESOURCE_PATH' do
      it 'is not nil' do
        expect(Achiever::Course::OccurrenceDetails::RESOURCE_PATH).not_to eq nil
      end
    end

    describe 'class methods' do
      describe '#find' do
        before do
          stub_occurrence_details
        end

        it 'returns an instance Achiever::Course::OccurrenceDetails' do
          expect(described_class.find('1')).to be_an_instance_of Achiever::Course::OccurrenceDetails
        end
      end
    end
  end
end

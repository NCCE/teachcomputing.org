require 'rails_helper'

RSpec.describe Achiever::Course::Occurrence do
  let(:course_occurrence) { described_class.face_to_face.first }

  describe 'accessor methods' do
    before do
      stub_face_to_face_occurrences
    end

    it 'provides the required accessor methods' do
      expect(course_occurrence).to respond_to(:activity_code)
      expect(course_occurrence).to respond_to(:activity_title)
      expect(course_occurrence).to respond_to(:address_venue_name)
      expect(course_occurrence).to respond_to(:address_venue_code)
      expect(course_occurrence).to respond_to(:address_town)
      expect(course_occurrence).to respond_to(:address_postcode)
      expect(course_occurrence).to respond_to(:address_line_one)
      expect(course_occurrence).to respond_to(:age_groups)
      expect(course_occurrence).to respond_to(:booking_url)
      expect(course_occurrence).to respond_to(:course_template_no)
      expect(course_occurrence).to respond_to(:course_occurrence_no)
      expect(course_occurrence).to respond_to(:end_date)
      expect(course_occurrence).to respond_to(:online_cpd)
      expect(course_occurrence).to respond_to(:remote_delivered_cpd)
      expect(course_occurrence).to respond_to(:region)
      expect(course_occurrence).to respond_to(:subject)
      expect(course_occurrence).to respond_to(:start_date)
    end
  end

  describe 'constants' do
    describe 'FACE_TO_FACE_RESOURCE_PATH' do
      it 'is not nil' do
        expect(Achiever::Course::Occurrence::FACE_TO_FACE_RESOURCE_PATH).not_to eq nil
      end
    end

    describe 'ONLINE_RESOURCE_PATH' do
      it 'is not nil' do
        expect(Achiever::Course::Occurrence::ONLINE_RESOURCE_PATH).not_to eq nil
      end
    end

    describe 'QUERY_STRINGS' do
      it 'contains page' do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:Page)
      end

      it 'contains record count' do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:RecordCount)
      end

      it 'contains end date' do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:EndDate)
      end

      it 'contains id' do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:ProgrammeName)
      end
    end

    describe 'class methods' do
      describe '#face_to_face' do
        before do
          stub_face_to_face_occurrences
        end

        it 'returns an array' do
          expect(described_class.face_to_face).to be_an Array
        end

        it 'the array contains Achiever::Course::Occurrence objects' do
          expect(described_class.face_to_face.sample).to be_an described_class
        end
      end

      describe '#online' do
        before do
          stub_online_occurrences
        end

        it 'returns an array' do
          expect(described_class.online).to be_an Array
        end

        it 'the array contains Achiever::Course::Occurrence objects' do
          expect(described_class.online.sample).to be_an described_class
        end
      end
    end
  end

  describe '@remote_delivered_cpd' do
    before do
      stub_face_to_face_occurrences
    end

    it 'is set to true if the API sets it so' do
      expect(described_class.face_to_face.select {|o| o.remote_delivered_cpd }.size).to eq(1)
    end
  end
end

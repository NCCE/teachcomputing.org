require 'rails_helper'

RSpec.describe Achiever::Course::Occurrence do
  let(:course_occurrence) { described_class.face_to_face.first }

  describe 'accessor methods' do
    before do
      stub_face_to_face_occurrences
    end

    it 'responds to activity_code' do
      expect(course_occurrence).to respond_to(:activity_code)
    end

    it 'responds to activity_title' do
      expect(course_occurrence).to respond_to(:activity_title)
    end

    it 'responds to address_venue_name' do
      expect(course_occurrence).to respond_to(:address_venue_name)
    end

    it 'responds to address_venue_code' do
      expect(course_occurrence).to respond_to(:address_venue_code)
    end

    it 'responds to address_town' do
      expect(course_occurrence).to respond_to(:address_town)
    end

    it 'responds to address_postcode' do
      expect(course_occurrence).to respond_to(:address_postcode)
    end

    it 'responds to address_line_one' do
      expect(course_occurrence).to respond_to(:address_line_one)
    end

    it 'responds to age_groups' do
      expect(course_occurrence).to respond_to(:age_groups)
    end

    it 'responds to booking_url' do
      expect(course_occurrence).to respond_to(:booking_url)
    end

    it 'responds to course_template_no' do
      expect(course_occurrence).to respond_to(:course_template_no)
    end

    it 'responds to course_occurrence_no' do
      expect(course_occurrence).to respond_to(:course_occurrence_no)
    end

    it 'responds to end_date' do
      expect(course_occurrence).to respond_to(:end_date)
    end

    it 'responds to online_cpd' do
      expect(course_occurrence).to respond_to(:online_cpd)
    end

    it 'responds to region' do
      expect(course_occurrence).to respond_to(:region)
    end

    it 'responds to subject' do
      expect(course_occurrence).to respond_to(:subject)
    end

    it 'responds to start_date' do
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

      it 'contains date' do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:Date)
      end

      it 'contains end date' do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:EndDate)
      end

      it 'contains id' do
        expect(Achiever::Course::Occurrence::QUERY_STRINGS).to have_key(:ID)
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
end

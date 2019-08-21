require 'rails_helper'

RSpec.describe Achiever::Course::Template do
  let(:course_template) { described_class.all.first }

  describe 'accessor methods' do
    before do
      stub_course_templates
    end

    it 'provides the required accessor methods' do
      expect(course_template).to respond_to(:activity_code)
      expect(course_template).to respond_to(:age_groups)
      expect(course_template).to respond_to(:booking_url)
      expect(course_template).to respond_to(:course_template_no)
      expect(course_template).to respond_to(:meta_description)
      expect(course_template).to respond_to(:occurrences)
      expect(course_template).to respond_to(:online_cpd)
      expect(course_template).to respond_to(:subjects)
      expect(course_template).to respond_to(:summary)
      expect(course_template).to respond_to(:title)
      expect(course_template).to respond_to(:workstream)
    end
  end

  describe 'constants' do
    describe 'RESOURCE_PATH' do
      it 'is not nil' do
        expect(Achiever::Course::Template::RESOURCE_PATH).not_to eq nil
      end
    end

    describe 'QUERY_STRINGS' do
      it 'contains page' do
        expect(Achiever::Course::Template::QUERY_STRINGS).to have_key(:Page)
      end

      it 'contains record count' do
        expect(Achiever::Course::Template::QUERY_STRINGS).to have_key(:RecordCount)
      end

      it 'contains hide from web' do
        expect(Achiever::Course::Template::QUERY_STRINGS).to have_key(:HideFromweb)
      end

      it 'contains programme id' do
        expect(Achiever::Course::Template::QUERY_STRINGS).to have_key(:ProgrammeID)
      end
    end
  end

  describe 'class methods' do
    describe '#all' do
      before do
        stub_course_templates
      end

      it 'returns an array' do
        expect(described_class.all).to be_an Array
      end

      it 'the array contains Achiever::Course::Template objects' do
        expect(described_class.all.sample).to be_an described_class
      end
    end
  end
end
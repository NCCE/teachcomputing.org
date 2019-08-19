require 'rails_helper'

RSpec.describe Achiever::Course::Template do
  let(:course_template) { described_class.all.first }

  describe 'accessor methods' do
    before do
      stub_course_templates
    end

    it 'responds to activity_code' do
      expect(course_template).to respond_to(:activity_code)
    end

    it 'responds to age_groups' do
      expect(course_template).to respond_to(:age_groups)
    end

    it 'responds to booking_url' do
      expect(course_template).to respond_to(:booking_url)
    end

    it 'responds to course_template_no' do
      expect(course_template).to respond_to(:course_template_no)
    end

    it 'responds to meta_description' do
      expect(course_template).to respond_to(:meta_description)
    end

    it 'responds to occurrences' do
      expect(course_template).to respond_to(:occurrences)
    end

    it 'responds to online_cpd' do
      expect(course_template).to respond_to(:online_cpd)
    end

    it 'responds to subjects' do
      expect(course_template).to respond_to(:subjects)
    end

    it 'responds to summary' do
      expect(course_template).to respond_to(:summary)
    end

    it 'responds to title' do
      expect(course_template).to respond_to(:title)
    end

    it 'responds to workstream' do
      expect(course_template).to respond_to(:workstream)
    end
  end

  describe 'constants' do
    describe 'RESOURCE_PATH' do
      it 'is not nil' do
        expect(Achiever::Course::Template::RESOURCE_PATH).not_to eq nil
      end
    end

    describe 'TYPE' do
      it 'is not nil' do
        expect(Achiever::Course::Template::TYPE).not_to eq nil
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
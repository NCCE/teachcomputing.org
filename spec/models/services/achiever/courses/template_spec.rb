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
      expect(course_template).to respond_to(:outcomes)
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
        expect(Achiever::Course::Template::QUERY_STRINGS).to have_key(:ProgrammeName)
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

    describe '#find_by_activity_code' do
      before do
        stub_course_templates
      end
      
      context 'when a template exists' do
        it 'returns the Achiever::Course::Template instance' do
          expect(described_class.find_by_activity_code('CP201')).to be_an described_class
        end
      end

      context 'when a template does not exists' do
        it 'raises a 404 exception' do
          expect { described_class.find_by_activity_code('111') }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe '#by_certificate' do
    before do
      stub_age_groups
      stub_course_templates
    end

    context 'when the programme is cs accelerator' do
      it 'returns true when the template is part of the programme' do
        template = described_class.all.first
        expect(template.by_certificate('cs-accelerator')).to eq true
      end
    end

    context 'when the template is not part of the programme' do
      it 'returns false' do 
        template = described_class.all.second
        expect(template.by_certificate('primary-certificate')).to eq false
      end
    end
  end

  describe '#with_occurrences' do
    before do
      stub_course_templates
      stub_face_to_face_occurrences
    end

    it 'returns a collection of with_occurrences' do
      expect(described_class.all.first.with_occurrences.count).to eq 4
    end
  end
end

require 'rails_helper'

RSpec.describe Pathway, type: :model do
  let(:pathway) { create(:pathway) }

  describe 'associations' do
    it { is_expected.to belong_to(:programme) }
    it { is_expected.to have_many(:user_programme_enrolments) }
    it { is_expected.to have_many(:pathway_activities) }
  end

  describe '.ordered' do
    it 'returns pathways ordered by the "order" column value' do
      last_pathway = create(:pathway, order: 3)
      first_pathway = create(:pathway, order: 1)
      middle_pathway = create(:pathway, order: 2)
      expect(described_class.ordered).to eq([first_pathway, middle_pathway,
                                             last_pathway])
    end
  end

  describe '#recommended_activities' do
    it 'returns pathway_activities not set as supplementary' do
      recommended = create_list(:pathway_activity, 3, pathway: pathway, supplementary: false)
      create_list(:pathway_activity, 3, pathway: pathway, supplementary: true)
      expect(pathway.recommended_activities).to match_array(recommended)
    end
  end

  describe '#supplementary_activities' do
    it 'returns pathway_activities set as supplementary' do
      create_list(:pathway_activity, 3, pathway: pathway, supplementary: false)
      supplementary = create_list(:pathway_activity, 3, pathway: pathway, supplementary: true)
      expect(pathway.supplementary_activities).to match_array(supplementary)
    end
  end

  describe '#recommended_courses' do
    it 'returns the course data for recommended_activities' do
      templates = [
        build(:achiever_course_template, activity_code: 'A001'),
        build(:achiever_course_template, activity_code: 'A002'),
        build(:achiever_course_template, activity_code: 'A003'),
        build(:achiever_course_template, activity_code: 'A004')
      ]

      allow(Achiever::Course::Template).to receive(:all).and_return(templates)
      create(:pathway_activity, pathway: pathway, supplementary: false,
                                activity: create(:activity, stem_activity_code: 'A001'))
      create(:pathway_activity, pathway: pathway, supplementary: false,
                                activity: create(:activity, stem_activity_code: 'A002'))
      expect(pathway.recommended_courses).to match_array(templates.slice(0, 2))
    end
  end

  describe '#supplementary_courses' do
    it 'returns the course data for recommended_activities' do
      templates = [
        build(:achiever_course_template, activity_code: 'A001'),
        build(:achiever_course_template, activity_code: 'A002'),
        build(:achiever_course_template, activity_code: 'A003'),
        build(:achiever_course_template, activity_code: 'A004')
      ]

      allow(Achiever::Course::Template).to receive(:all).and_return(templates)
      create(:pathway_activity, pathway: pathway, supplementary: true,
                                activity: create(:activity, stem_activity_code: 'A003'))
      create(:pathway_activity, pathway: pathway, supplementary: true,
                                activity: create(:activity, stem_activity_code: 'A004'))
      expect(pathway.supplementary_courses).to match_array(templates.slice(2, 2))
    end
  end
end

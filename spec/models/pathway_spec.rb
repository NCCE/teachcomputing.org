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
      prog = create(:cs_accelerator)
      last_pathway = create(:pathway, order: 3, programme: prog)
      first_pathway = create(:pathway, order: 1, programme: prog)
      middle_pathway = create(:pathway, order: 2, programme: prog)
      expect(described_class.ordered('cs-accelerator')).to eq([first_pathway, middle_pathway,
                                                               last_pathway])
    end

    it 'only shows pathways from the relevant programme' do
      prog = create(:cs_accelerator)
      prog_2 = create(:primary_certificate)
      last_pathway = create(:pathway, order: 3, programme: prog)
      first_pathway = create(:pathway, order: 1, programme: prog_2)
      middle_pathway = create(:pathway, order: 2, programme: prog)
      expect(described_class.ordered('cs-accelerator')).to eq([middle_pathway,
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

  describe '#recommended_activities_for_user' do
    it 'returns pathway_activities not set as supplementary where user is not taking course' do
      user = create(:user)
      activity = create(:activity)
      create(:achievement, user: user, activity: activity)
      create(:pathway_activity, pathway: pathway, activity: activity, supplementary: false)
      recommended = create_list(:pathway_activity, 3, pathway: pathway, supplementary: false)
      expect(pathway.recommended_activities_for_user(user)).to match_array(recommended)
    end
  end

  describe '#supplementary_activities_for_user' do
    it 'returns pathway_activities set as supplementary where user is not taking course' do
      user = create(:user)
      activity = create(:activity)
      create(:achievement, user: user, activity: activity)
      create(:pathway_activity, pathway: pathway, activity: activity, supplementary: true)
      supplementary = create_list(:pathway_activity, 3, pathway: pathway, supplementary: true)
      expect(pathway.supplementary_activities_for_user(user)).to match_array(supplementary)
    end
  end
end

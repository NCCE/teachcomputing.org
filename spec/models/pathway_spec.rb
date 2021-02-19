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
end

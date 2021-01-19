require 'rails_helper'

RSpec.describe PathwayActivity, type: :model do
  let(:pathway_activity) { create(:pathway_activity) }

  describe 'associations' do
    it 'belongs_to pathway' do
      expect(pathway_activity).to belong_to(:pathway)
    end

    it 'belongs_to activity' do
      expect(pathway_activity).to belong_to(:activity)
    end
  end
end

require 'rails_helper'

RSpec.describe Pathway, type: :model do
  let(:pathway) { create(:pathway) }

  describe 'associations' do
    it { is_expected.to belong_to(:programme) }
    it { is_expected.to have_many(:user_programme_enrolments) }
    it { is_expected.to have_many(:pathway_activities) }
  end
end

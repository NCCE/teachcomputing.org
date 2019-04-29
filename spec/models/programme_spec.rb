require 'rails_helper'

RSpec.describe Programme, type: :model do
  let(:programme) { create(:programme) }

  describe 'associations' do
    it 'has_many programmes' do
      expect(programme).to have_many(:activities).through(:programme_activities)
    end

    it 'has_many users' do
      expect(programme).to have_many(:users).through(:user_programme_enrolments)
    end
  end
end

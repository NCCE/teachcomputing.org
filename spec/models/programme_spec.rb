require 'rails_helper'

RSpec.describe Programme, type: :model do
  let(:programme) { create(:programme) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }

  describe 'associations' do
    it 'has_many activities' do
      expect(programme).to have_many(:activities).through(:programme_activities)
    end

    it 'has_many users' do
      expect(programme).to have_many(:users).through(:user_programme_enrolments)
    end

    it 'has_one assessment' do
      expect(programme).to have_one(:assessment)
    end
  end

  describe '#user_enrolled?' do
    it 'returns true if user is enrolled on the programme' do
      user_programme_enrolment
      expect(programme.user_enrolled?(user)).to eq(true)
    end

    it 'returns false if user is not enrolled on the programme' do
      expect(programme.user_enrolled?(user)).to eq(false)
    end

    it 'returns false if user not defined' do
      expect(programme.user_enrolled?(nil)).to eq(false)
    end
  end
end

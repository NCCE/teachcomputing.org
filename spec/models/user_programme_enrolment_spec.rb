require 'rails_helper'

RSpec.describe UserProgrammeEnrolment, type: :model do
  let(:user_programme_enrolment) { create(:user_programme_enrolment) }

  describe 'associations' do
    it 'belongs to programme' do
      expect(user_programme_enrolment).to belong_to(:programme)
    end

    it 'belongs to user' do
      expect(user_programme_enrolment).to belong_to(:user)
    end

    it 'has many user programme enrolment transitions' do
      expect(user_programme_enrolment).to have_many(:user_programme_enrolment_transitions)
    end
  end
end

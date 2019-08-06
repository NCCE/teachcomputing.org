require 'rails_helper'

RSpec.describe Programme, type: :model do
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:programmes) { create_list(:programme, 3) }
  let(:primary_programme) { create(:programme, slug: 'primary') }
  let(:non_enrollable_programme) { create(:programme, enrollable: false ) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam )}
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }


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

  describe 'scopes' do
    describe '#enrollable' do
      before do
        programmes
        non_enrollable_programme
      end

      it 'contains only programmes that are enrollable' do
        expect(Programme.enrollable).to eq programmes
        expect(Programme.enrollable).to_not include non_enrollable_programme
      end
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

  describe '#cs_accelerator' do
    before do
      programme
    end

    it 'returns the cs-accelerator record' do
      expect(Programme.cs_accelerator).to eq programme
    end
  end

  describe '#primary' do
    before do
      primary_programme
    end

    it 'returns the primary record' do
      expect(Programme.primary).to eq primary_programme
    end
  end

  describe '#user_completed?' do
    context 'when user is not passed in' do
      it 'raises error if user is nil' do
        expect {
          programme.user_completed?(nil)
        }.to raise_error(NoMethodError)
      end
    end

    before do
      programme_activity
      user_programme_enrolment
    end
    context 'when user has not completed programme' do
      it 'returns false' do
        expect(programme.user_completed?(user)).to eq false
      end
    end

    context 'when user has completed programme' do
      before do
        passed_exam
      end

      it 'returns true' do
        expect(programme.user_completed?(user)).to eq true
      end
    end
  end
end

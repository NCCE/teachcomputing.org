require 'rails_helper'

RSpec.describe Programme, type: :model do
  let(:generic_programme) { create(:programme) }
  let(:programme) { create(:cs_accelerator) }
  let(:programmes) { create_list(:programme, 3) }
  let(:diagnostic) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:primary_programme) { create(:primary_certificate) }
  let(:secondary_programme) { create(:secondary_certificate) }
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

    it 'has_one programme_complete_counter' do
      expect(programme).to have_one(:programme_complete_counter)
    end

    it 'has_one questionnaire' do
      expect(programme).to have_many(:questionnaire)
    end

    it 'has_many questionnaire_responses' do
      expect(programme).to have_many(:questionnaire_response)
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

  describe '#diagnostic' do
    context 'when an associated diagnostic activity exists' do
      it 'returns record' do
        generic_programme.activities << diagnostic
        expect(generic_programme.diagnostic).to eq diagnostic
      end
    end

    context 'when an associated diagnostic activity exists' do
      it 'returns nil' do
        expect(generic_programme.diagnostic).to eq nil
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

  describe '#primary_certificate' do
    before do
      primary_programme
    end

    it 'returns the primary record' do
      expect(Programme.primary_certificate).to eq primary_programme
    end

    it 'returns the correct type' do
      expect(Programme.primary_certificate).to be_a(Programmes::PrimaryCertificate)
    end
  end

  describe '#secondary_certificate' do
    before do
      secondary_programme
    end

    it 'returns the secondary record' do
      expect(Programme.secondary_certificate).to eq secondary_programme
    end

    it 'returns the correct type' do
      expect(Programme.secondary_certificate).to be_a(Programmes::SecondaryCertificate)
    end
  end

  describe '#user_completed?' do
    context 'when the user is enrolled' do
      it 'returns false' do
        user_programme_enrolment
        expect(programme.user_completed?(user)).to eq false
      end
    end

    context 'when the user is pending' do
      it 'returns false' do
        user_programme_enrolment.transition_to(:pending)
        expect(programme.user_completed?(user)).to eq false
      end
    end

    context 'when the user is complete' do
      it 'returns true' do
        user_programme_enrolment.transition_to(:complete)
        expect(programme.user_completed?(user)).to eq true
      end
    end
  end

  describe '#credits_achieved_for_certificate' do
    it 'returns 0' do
      expect(programmes[0].credits_achieved_for_certificate(user)).to eq 0
    end
  end

  describe '#max_credits_for_certificate' do
    it 'returns 0' do
      expect(programmes[0].max_credits_for_certificate).to eq 0
    end
  end

  describe '#enough_activites_for_test?' do
    it 'returns 0' do
      expect(programmes[0].enough_activites_for_test?(user)).to eq false
    end
  end

end

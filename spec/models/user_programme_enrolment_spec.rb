require 'rails_helper'

RSpec.describe UserProgrammeEnrolment, type: :model do
  let(:user) { create(:user) }
  let(:achievements) { create_list(:achievement, 5, user: user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, user: user, programme: cs_accelerator) }

  describe 'associations' do
    it 'belongs to programme' do
      expect(cs_accelerator_enrolment).to belong_to(:programme)
    end

    it 'belongs to user' do
      expect(cs_accelerator_enrolment).to belong_to(:user)
    end

    it 'has many user programme enrolment transitions' do
      expect(cs_accelerator_enrolment).to have_many(:user_programme_enrolment_transitions)
    end

    it 'only allows a unique enrolment per programme/user' do
      expect do
        create(:user_programme_enrolment, user: user, programme: cs_accelerator)
        create(:user_programme_enrolment, user: user, programme: cs_accelerator)
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe '#completed_at?' do

    it 'returns nil' do
      expect(cs_accelerator_enrolment.completed_at?).to eq nil
    end

    context 'when complete' do
      it 'returns the date of transition' do
        cs_accelerator_enrolment.transition_to(:complete)
        expect(cs_accelerator_enrolment.created_at?).to_not eq nil
      end
    end
  end

  describe '#set_eligible_achievements_for_programme' do
    before do
      cs_accelerator
      achievements
      Activity.all.each do |activity|
        create(:programme_activity, programme: cs_accelerator, activity: activity)
      end
    end

    it 'sets the programme_id for the achievements relating to the programe ' do
      create(:user_programme_enrolment, user: user, programme: cs_accelerator)
      expect(user.achievements.pluck(:programme_id).uniq).to include cs_accelerator.id
    end
  end

  describe '#after_commit callbacks' do
    describe '#schedule_kick_off_email' do
      context 'when Secondary certificate' do
        it 'sends SecondaryMailer' do
          expect do
            cs_accelerator_enrolment
          end.to have_enqueued_job(KickOffEmailsJob).with(user.id, cs_accelerator.id)
        end
      end
    end
  end

  describe 'delegates' do
    it { is_expected.to delegate_method(:can_transition_to?).to(:state_machine).as(:can_transition_to?) }
    it { is_expected.to delegate_method(:current_state).to(:state_machine).as(:current_state) }
    it { is_expected.to delegate_method(:transition_to).to(:state_machine).as(:transition_to) }
    it { is_expected.to delegate_method(:last_transition).to(:state_machine).as(:last_transition) }
    it { is_expected.to delegate_method(:in_state?).to(:state_machine).as(:in_state?) }
  end
end

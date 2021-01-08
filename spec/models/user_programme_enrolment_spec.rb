
require 'rails_helper'

RSpec.describe UserProgrammeEnrolment, type: :model do
  let(:user) { create(:user) }
  let(:achievements) { create_list(:achievement, 5, user: user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, user: user, programme: cs_accelerator) }

  describe 'associations' do
    it { is_expected.to belong_to(:programme) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:user_programme_enrolment_transitions) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:programme) }

    it 'ensures user can only be enrolled on a programme once' do
      create(:user_programme_enrolment, user: user, programme: cs_accelerator)
      enrolment = build(:user_programme_enrolment, user: user, programme: cs_accelerator)
      expect(enrolment.valid?).to eq(false)
      expect(enrolment.errors.messages[:user]).to eq(['has already been taken'])
    end
  end

  describe '#completed_at?' do
    it 'returns nil' do
      expect(cs_accelerator_enrolment.completed_at?).to eq nil
    end

    context 'when complete' do
      it 'returns the date of transition' do
        cs_accelerator_enrolment.transition_to(:complete)
        expect(cs_accelerator_enrolment.created_at?).not_to eq nil
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
    it 'queues CompleteCertificateEmailJob job' do
      expect do
        create(:user_programme_enrolment)
      end.to have_enqueued_job(KickOffEmailsJob)
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

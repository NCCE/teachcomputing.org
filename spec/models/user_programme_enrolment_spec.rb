require 'rails_helper'

RSpec.describe UserProgrammeEnrolment, type: :model do
  let(:user) { create(:user) }
  let(:achievements) { create_list(:achievement, 5, user: user) }
  let(:programme) { create(:cs_accelerator) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

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

    it 'queues CompleteCertificateEmailJob job' do
      expect do
        user_programme_enrolment
      end.to have_enqueued_job(ScheduleProgrammeGettingStartedPromptJob).with(user.id, programme.id)
    end

    it 'only allows a unique enrolment per programme/user' do
      expect do
        create(:user_programme_enrolment, user: user, programme: programme)
        create(:user_programme_enrolment, user: user, programme: programme)
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe '#completed_at?' do

    it 'returns nil' do
      expect(user_programme_enrolment.completed_at?).to eq nil
    end

    context 'when complete' do
      it 'returns the date of transition' do
        user_programme_enrolment.transition_to(:complete)
        expect(user_programme_enrolment.created_at?).to_not eq nil
      end
    end
  end

  describe '#set_eligible_achievements_for_programme' do
    before do
      programme
      achievements
      Activity.all.each do |activity|
        create(:programme_activity, programme: programme, activity: activity)
      end
    end
    it 'sets the programme_id for the achievements relating to the programe ' do
      create(:user_programme_enrolment, user: user, programme: programme)
      expect(user.achievements.pluck(:programme_id).uniq).to include programme.id
    end
  end
end

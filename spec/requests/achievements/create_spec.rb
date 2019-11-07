require 'rails_helper'

RSpec.describe AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :stem_learning) }
  let (:referrer) { 'https://testing123.com' }
  let(:programme) { create(:primary_certificate) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: activity.id) }


  describe 'POST #create' do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context 'with valid params' do
      include ActiveJob::TestHelper

      subject do
        programme_activity
        post achievements_path,
             params: {
               achievement: { activity_id: activity.id }
             }
      end

      before do
        subject
      end

      after do
        clear_enqueued_jobs
      end

      it 'redirects to the dashboard path' do
        expect(response).to redirect_to(dashboard_path)
      end

      it 'creates the Achievement' do
        expect(user.achievements.where(activity_id: activity.id).exists?).to eq true
      end

      it 'creates an achievement with the correct complete state' do
        expect(user.achievements.where(activity_id: activity.id).first.current_state).to eq 'complete'
      end

      it 'creates an achievement with the correct activity credit' do
        transition = user.achievements.where(activity_id: activity.id).first.last_transition
        expect(transition.metadata['credit']).to eq activity.credit
      end

      it 'creates an achievement without the self_verification param' do
        transition = user.achievements.where(activity_id: activity.id).first.last_transition
        expect(transition.metadata['self_verification_info']).to be(nil)
      end

      it 'shows a flash notice' do
        expect(flash[:notice]).to be_present
      end

      it 'flash notice has correct info' do
        expect(flash[:notice]).to match(/'#{activity.title}' has been added/)
      end

      it 'queues PrimaryCertificatePendingTransitionJob job' do
        expect(PrimaryCertificatePendingTransitionJob).to have_been_enqueued.exactly(:once)
      end
    end

    context 'with invalid params' do
      subject do
        post achievements_path,
             params: {
               achievement: { activity_id: nil }
             }
      end

      before do
        subject
      end

      it 'redirects to the dashboard path by default' do
        expect(response).to redirect_to(dashboard_path)
      end

      it 'does not create an Achievement' do
        expect(user.achievements.where(activity_id: activity.id).exists?).to eq false
      end

      it 'shows a flash error' do
        expect(flash[:error]).to be_present
      end

      it 'flash error has correct info' do
        expect(flash[:error]).to match(/something went wrong adding/)
      end
    end

    context 'with referrer header' do
      subject do
        allow_any_instance_of(
          described_class
        ).to(
          receive(:self_verification_url).and_return(
            referrer
          )
        )
        post achievements_path,
             params: {
               achievement: { activity_id: nil }
             },
             headers: { 'HTTP_REFERER' => referrer }
      end

      before do
        subject
      end

      it 'redirects to the referrer if specified' do
          expect(response).to redirect_to(referrer)
      end
    end

    context 'with self_verification param' do
      subject do
        post achievements_path,
             params: {
               achievement: { activity_id: activity.id },
               self_verification_info: 'This is a test'
             }
      end

      it 'it is added to the achievement transition' do
        post achievements_path,
              params: {
                achievement: { activity_id: activity.id },
                self_verification_info: 'This is a test'
              }
        transition = user.achievements.where(activity_id: activity.id).first.last_transition
        expect(transition.metadata['self_verification_info']).to eq('This is a test')
      end

      it 'empty strings are not stored' do
        post achievements_path,
              params: {
                achievement: { activity_id: activity.id },
                self_verification_info: ''
              }
        transition = user.achievements.where(activity_id: activity.id).first.last_transition
        expect(transition.metadata['self_verification_info']).to be(nil)
      end
    end
  end
end

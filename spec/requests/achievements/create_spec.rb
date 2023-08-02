require 'rails_helper'

RSpec.describe AchievementsController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :stem_learning, self_verification_info: self_verification_info) }
  let(:self_verification_info) { 'Please provide a link to your contribution' }
  let(:referrer) { 'https://testing123.com' }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }
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
               achievement: { activity_id: activity.id },
               self_verification_info: 'My supporting evidence'
             }
      end

      before do
        subject
      end

      it 'redirects to the dashboard path' do
        expect(response).to redirect_to(dashboard_path)
      end

      it 'creates the Achievement' do
        expect(user.achievements.where(activity_id: activity.id).exists?).to be true
      end

      it 'creates an achievement with the correct complete state' do
        expect(user.achievements.where(activity_id: activity.id).first.current_state).to eq 'complete'
      end

      it 'creates an achievement with the correct activity credit' do
        transition = user.achievements.where(activity_id: activity.id).first.last_transition
        expect(transition.metadata['credit']).to eq activity.credit
      end

      it 'creates an achievement with the self_verification param' do
        transition = user.achievements.where(activity_id: activity.id).first.last_transition
        expect(transition.metadata['self_verification_info']).to eq('My supporting evidence')
      end

      it 'shows a flash notice' do
        expect(flash[:notice]).to match(/'#{activity.title}' has been added/)
      end

      it 'does not transition to pending' do
        expect(user_programme_enrolment.current_state).to eq 'enrolled'
      end
    end

    context 'with invalid params' do
      subject do
        post achievements_path,
             params: {
               achievement: { activity_id: nil },
               self_verification_info: 'My supporting evidence'
             }
      end

      before do
        subject
      end

      it 'redirects to the dashboard path by default' do
        expect(response).to redirect_to(dashboard_path)
      end

      it 'does not create an Achievement' do
        expect(user.achievements.where(activity_id: activity.id).exists?).to be false
      end

      it 'shows a flash error' do
        expect(flash[:error]).to match(/Activity must exist/)
      end
    end

    context 'without self_verification_info param' do
      subject do
        post achievements_path,
             params: {
               achievement: { activity_id: activity.id }
             }
      end

      before do
        subject
      end

      it 'redirects to the dashboard path by default' do
        expect(response).to redirect_to(dashboard_path)
      end

      it 'does not create an Achievement' do
        expect(user.achievements.where(activity_id: activity.id).exists?).to be false
      end

      it 'shows a flash error' do
        expect(flash[:error]).to match(/You must provide supporting evidence for/)
      end

      context 'when the activity has no self_verification_info' do
        let(:self_verification_info) { nil }

        subject do
          post achievements_path,
               params: {
                 achievement: { activity_id: activity.id }
               }
        end

        before do
          subject
        end

        it 'redirects to the dashboard path by default' do
          expect(response).to redirect_to(dashboard_path)
        end

        it 'creates an Achievement' do
          expect(user.achievements.where(activity_id: activity.id).exists?).to be true
        end

        it 'shows a flash success' do
          expect(flash[:notice]).to match(/'#{activity.title}' has been added/)
        end
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
               achievement: { activity_id: nil },
               self_verification_info: 'Info'
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

    context 'with supporting_evidence params' do
      context 'with a valid file' do
        before do
          post achievements_path,
               params: {
                 achievement: {
                   activity_id: activity.id,
                   supporting_evidence: Rack::Test::UploadedFile.new(
                     'spec/support/active_storage/supporting_evidence_test_upload.png', 'image/png'
                   )
                 }
               }
        end

        it 'uploads the attachment to the achievement' do
          expect(user.achievements.where(activity_id: activity.id).first.supporting_evidence.attached?).to be true
        end

        it 'sets supporting_evidence metadata' do
          transition = user.achievements.where(activity_id: activity.id).first.last_transition
          expect(transition.metadata['self_verification_info']).not_to be_nil
        end
      end

      context 'with an invalid file' do
        before do
          post achievements_path,
               params: {
                 achievement: {
                   activity_id: activity.id,
                   supporting_evidence: Rack::Test::UploadedFile.new(
                     'spec/support/active_storage/supporting_evidence_invalid_test_upload.txt', 'text/plain'
                   )
                 }
               }
        end

        it 'does not create the achievement' do
          expect(user.achievements.where(activity_id: activity.id).exists?).to be false
        end

        it 'renders a flash error' do
          expect(flash[:error]).to match(/Supporting evidence is not a valid file format/)
        end
      end
    end
  end
end

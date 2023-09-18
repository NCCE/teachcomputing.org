require 'rails_helper'

RSpec.describe UserProgrammeEnrolmentsController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:enrolment)  { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id, message_flags_primary_pathway_migrated: true) }

  describe 'GET #destroy_message_flags_primary_pathway_migrated' do
    before do
      user
      enrolment
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    it 'should set the flag to nil' do
      delete destroy_message_flags_primary_pathway_migrated_user_programme_enrolments_path

      expect(enrolment.reload.message_flags_primary_pathway_migrated).to be nil
    end

    it 'should redirect to primary certificate page' do
      delete destroy_message_flags_primary_pathway_migrated_user_programme_enrolments_path

      expect(response).to redirect_to(programme.path)
    end

    context 'when it fails to update' do
      it 'should provide a flash message' do
        expect_any_instance_of(UserProgrammeEnrolment).to receive(:update).with(message_flags_primary_pathway_migrated: nil).and_return(false)

        delete destroy_message_flags_primary_pathway_migrated_user_programme_enrolments_path

        expect(flash[:error]).to be_present
      end
    end
  end
end

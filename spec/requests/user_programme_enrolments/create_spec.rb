require 'rails_helper'

RSpec.describe UserProgrammeEnrolmentsController do
  let(:user) { create(:user) }
  let(:programme) { create(:programme) }

  describe 'POST #create' do
    before do
      user
      programme
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context 'with valid params' do
      subject do
        post user_programme_enrolment_path(slug: programme.slug, user_programme_enrolment: { programme_id: programme.id, user_id: user.id })
      end

      before do
        subject
      end

      it 'redirects to the dashboard path' do
        expect(response).to redirect_to("/certificate/#{programme.slug}")
      end

      it 'creates the UserProgrammeEnrolment' do
        expect(user.user_programme_enrolments.where(programme_id: programme.id).exists?).to eq true
      end
    end

    context 'with invalid params' do
      it 'raises ActiveRecord::RecordNotFound exception' do
        expect do
          post user_programme_enrolment_path(slug: programme.slug, user_programme_enrolment: { programme_id: nil, user_id: nil })
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'enrolling twice' do
      subject do
        post user_programme_enrolment_path(slug: programme.slug, user_programme_enrolment: { programme_id: programme.id, user_id: user.id })
        post user_programme_enrolment_path(slug: programme.slug, user_programme_enrolment: { programme_id: programme.id, user_id: user.id })
      end

      before do
        RSpec::Expectations.configuration.on_potential_false_positives = :nothing
      end

      after do
        RSpec::Expectations.configuration.on_potential_false_positives = :warn
      end

      it 'does not throw an error' do
        expect do
          subject
        end.not_to raise_error(ActiveRecord::RecordNotUnique)
      end

      it 'redirects to the correct path' do
        subject
        expect(response).to redirect_to("/certificate/#{programme.slug}")
      end
    end
  end
end

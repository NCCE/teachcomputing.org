require 'rails_helper'

RSpec.describe UserProgrammeEnrolmentsController do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }

  describe 'POST #create' do
    before do
      user
      programme
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context 'with valid params' do
      subject(:enrol) do
        post enrol_cs_accelerator_certificate_path(user_programme_enrolment: { programme_id: programme.id,
                                                                               user_id: user.id })
      end

      it 'redirects to the dashboard path' do
        enrol
        expect(response).to redirect_to(cs_accelerator_certificate_path)
      end

      it 'creates the UserProgrammeEnrolment' do
        enrol
        expect(user.user_programme_enrolments.where(programme_id: programme.id).exists?).to eq true
      end

      it 'displays flash message' do
        enrol
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match(/Congratulations, you have enrolled on our #{programme.title}/)
      end

      it 'fetches courses from dynamics' do
        expect { enrol }.to have_enqueued_job(Achiever::FetchUsersCompletedCoursesFromAchieverJob)
      end

      context 'when user has unenrolled from certificate after auto enrolment' do
        let(:enrolment) do
          UserProgrammeEnrolment.create(user: user,
                                        programme: programme,
                                        auto_enrolled: true)
        end

        before do
          enrolment.transition_to(:unenrolled)
        end

        it 'sets the enrolment to enrolled state' do
          enrol
          updated_enrolment = UserProgrammeEnrolment.find(enrolment.id)
          expect(updated_enrolment.in_state?(:enrolled)).to eq(true)
        end

        it 'sets the enrolment auto_enrolled value to false' do
          enrol
          updated_enrolment = UserProgrammeEnrolment.find(enrolment.id)
          expect(updated_enrolment.auto_enrolled).to eq(false)
        end

        it 'redirects to dashboard' do
          enrol
          expect(response).to redirect_to(cs_accelerator_certificate_path)
        end

        it 'displays flash message' do
          enrol
          expect(flash[:notice]).to be_present
          expect(flash[:notice]).to match(/Congratulations, you have enrolled on our #{programme.title}/)
        end
      end
    end

    context 'with invalid params' do
      it 'raises ActiveRecord::RecordNotFound exception' do
        expect do
          post enrol_cs_accelerator_certificate_path(user_programme_enrolment: { programme_id: nil, user_id: nil })
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when attempting to enrol twice' do
      subject do
        post enrol_cs_accelerator_certificate_path(user_programme_enrolment: { programme_id: programme.id,
                                                                               user_id: user.id })
        post enrol_cs_accelerator_certificate_path(user_programme_enrolment: { programme_id: programme.id,
                                                                               user_id: user.id })
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

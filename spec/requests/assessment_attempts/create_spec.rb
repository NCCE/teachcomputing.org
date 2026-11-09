require "rails_helper"

RSpec.describe AssessmentAttemptsController do
  let!(:user) { create(:user) }
  let!(:assessment) { create(:assessment) }

  describe "POST #create" do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context "with valid params" do
      it "creates an assessment attempt record" do
        post assessment_attempts_path(
          assessment_attempt: {assessment_id: assessment.id, user_id: user.id, accepted_conditions: true}
        )
        expect(AssessmentAttempt.where(assessment_id: assessment.id, user_id: user.id).exists?).to be true
      end

      it "redirects to the assessment link path" do
        post assessment_attempts_path(
          assessment_attempt: {assessment_id: assessment.id, user_id: user.id, accepted_conditions: true}
        )
        expect(response).to redirect_to("#{assessment.link}&cm_e=#{user.email}&cm_user_id=#{user.id}")
      end

      it "queues ExpireAssessmentAttemptJob job" do
        expect do
          post assessment_attempts_path(
            assessment_attempt: {assessment_id: assessment.id, user_id: user.id, accepted_conditions: true}
          )
        end.to have_enqueued_job(ExpireAssessmentAttemptJob)
      end

      it "doesn't store trn if not present" do
        post assessment_attempts_path(
          assessment_attempt: {assessment_id: assessment.id, user_id: user.id, accepted_conditions: true}
        )
        expect(user.teacher_reference_number).to be_nil
      end

      it "stores the trn if it is present" do
        path = assessment_attempts_path(
          assessment_attempt: {assessment_id: assessment.id, user_id: user.id, accepted_conditions: true}
        )
        post path, params: {
          user: {teacher_reference_number: "abc123"},
          accepted_conditions: true
        }
        expect(user.teacher_reference_number).to eq("abc123")
      end

      context "if the achievement fails to save" do
        it "should add a flash error" do
          allow_any_instance_of(Achievement).to receive(:save).and_return(false)
          allow_any_instance_of(Programme).to receive(:path).and_return(a_level_path)

          post assessment_attempts_path(
            assessment_attempt: {assessment_id: assessment.id, user_id: user.id, accepted_conditions: true}
          )

          expect(flash[:error]).to be_present
        end
      end

      context "if the assessment_attempt fails to save" do
        it "should add a flash error" do
          allow_any_instance_of(AssessmentAttempt).to receive(:save).and_return(false)
          allow_any_instance_of(Programme).to receive(:path).and_return(a_level_path)

          post assessment_attempts_path(
            assessment_attempt: {assessment_id: assessment.id, user_id: user.id, accepted_conditions: true}
          )

          expect(flash[:error]).to be_present
        end
      end
    end

    context "when the attempt rules don't allow a new attempt" do
      let(:a_level) { create(:a_level) }
      let!(:assessment) { create(:assessment, programme: a_level) }

      before do
        create(:user_programme_enrolment, user:, programme: a_level)
      end

      def post_attempt
        post assessment_attempts_path(
          assessment_attempt: {assessment_id: assessment.id, user_id: user.id, accepted_conditions: true}
        ), params: {user: {teacher_reference_number: "abc123"}}
      end

      context "with an attempt in progress" do
        before do
          travel_to(Time.zone.parse("2026-11-11 14:30"))
          create(:assessment_attempt, user:, assessment:, created_at: Time.zone.parse("2026-11-11 14:14"))
        end

        after { travel_back }

        it "does not create an attempt" do
          expect { post_attempt }.not_to change(AssessmentAttempt, :count)
        end

        it "redirects back to the dashboard" do
          post_attempt
          expect(response).to redirect_to(a_level.path)
        end

        it "says when they can start a new attempt" do
          post_attempt
          expect(flash[:error]).to eq("You've already started the test. If you didn't finish, you can start a new attempt after 4:14pm on Wednesday 11 November 2026.")
        end

        it "does not save the TRN" do
          post_attempt
          expect(user.reload.teacher_reference_number).to be_nil
        end
      end

      context "in the cool-off after two fails" do
        before do
          create_list(:failed_assessment_attempt, 2, user:, assessment:)
        end

        it "does not create an attempt" do
          expect { post_attempt }.not_to change(AssessmentAttempt, :count)
        end

        it "does not queue the expiry job" do
          expect { post_attempt }.not_to have_enqueued_job(ExpireAssessmentAttemptJob)
        end

        it "says when they can take the test again" do
          post_attempt
          expect(flash[:error]).to start_with("You can take the test again after")
        end
      end

      context "after one fail" do
        before do
          create(:failed_assessment_attempt, user:, assessment:)
        end

        it "creates an attempt" do
          expect { post_attempt }.to change(AssessmentAttempt, :count).by(1)
        end
      end

      context "without enough credits for the KS3 test" do
        let(:cs_accelerator) { create(:cs_accelerator) }
        let!(:assessment) { create(:assessment, programme: cs_accelerator) }

        it "does not create an attempt" do
          expect { post_attempt }.not_to change(AssessmentAttempt, :count)
        end

        it "tells them to complete more courses" do
          post_attempt
          expect(flash[:error]).to eq("You need to complete more courses before you can take the test.")
        end
      end
    end

    context "with invalid params" do
      it "raises ActiveRecord::RecordNotFound exception" do
        expect do
          post assessment_attempts_path(assessment_attempt: {assessment_id: nil, user_id: nil})
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

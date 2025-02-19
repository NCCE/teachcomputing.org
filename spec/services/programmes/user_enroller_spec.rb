require "rails_helper"

RSpec.describe Programmes::UserEnroller do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:enroller) { described_class.new(user_id: user.id, programme_id: programme.id, pathway_slug: programme.pathways.first&.slug) }

  describe "#call" do
    it "creates the user programme enrolment" do
      expect { enroller.call }.to change { user.user_programme_enrolments.count }.by(1)
      expect(user.user_programme_enrolments.where(programme_id: programme.id).exists?).to eq true
    end

    it "returns true" do
      expect(enroller.call).to eq(true)
    end

    it "schedules kick off emails" do
      expect { enroller.call }.to have_enqueued_job(KickOffEmailsJob)
    end

    it "schedules achiever sync" do
      expect { enroller.call }.to have_enqueued_job(Achiever::ScheduleCertificateSyncJob)
    end

    it "does not create questionnaire response for user" do
      expect { enroller.call }.not_to change(QuestionnaireResponse, :count)
    end

    context "when provided the auto enrolled argument with true" do
      let(:enroller) do
        described_class.new(
          user_id: user.id,
          programme_id: programme.id,
          pathway_slug: programme.pathways.first&.slug,
          auto_enrolled: true
        )
      end

      it "should create an autoenrolled UserProgrammeEnrollment" do
        enroller.call

        expect(UserProgrammeEnrolment.last.auto_enrolled).to be true
      end
    end

    context "when enrolling on cs_accelerator" do
      let(:programme) { create(:cs_accelerator) }

      it "creates questionnaire response for user" do
        create(:csa_enrolment_questionnaire)
        expect { enroller.call }.to change(QuestionnaireResponse, :count).by(1)
      end
    end

    context "with invalid params" do
      let(:enroller) { described_class.new(user_id: nil, programme_id: nil) }

      it "does not create an enrolment" do
        expect { enroller.call }.not_to change(UserProgrammeEnrolment, :count)
      end

      it "returns false" do
        expect(enroller.call).to eq(false)
      end
    end
  end
end

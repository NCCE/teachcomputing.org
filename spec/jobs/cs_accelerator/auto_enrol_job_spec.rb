require "rails_helper"

RSpec.describe CSAccelerator::AutoEnrolJob, type: :job do
  describe ".perform" do
    subject(:enrol_job) { described_class.perform_now(achievement_id: achievement.id) }

    let(:user) { create(:user) }
    let(:cs_accelerator) { create(:cs_accelerator) }
    let(:activity) { create(:activity) }
    let!(:achievement) do
      create(:programme_activity, activity: activity, programme: cs_accelerator)
      create(:achievement, activity: activity, user: user)
    end

    it "enrols user in csa" do
      expect { enrol_job }
        .to change { UserProgrammeEnrolment.where(programme: cs_accelerator).count }
        .by(1)
    end

    it "sets auto_enrolled flag" do
      enrol_job
      expect(UserProgrammeEnrolment.last.auto_enrolled).to eq(true)
    end

    context "when user is enrolled in csa" do
      before do
        create(:user_programme_enrolment, user: user, programme: cs_accelerator)
      end

      it "does not enrol user" do
        expect { enrol_job }
          .not_to change(UserProgrammeEnrolment, :count)
      end
    end

    context "when activity is in multiple programmes" do
      let(:primary_certificate) { create(:primary_certificate) }

      before do
        create(:programme_activity, activity: activity, programme: primary_certificate)
      end

      context "when user is enrolled in non csa programme" do
        context "when non csa enrolment is not complete" do
          before do
            create(:user_programme_enrolment, user: user, programme: primary_certificate)
          end

          it "does not enrol user" do
            expect { enrol_job }
              .not_to change(UserProgrammeEnrolment, :count)
          end
        end

        context "when non csa enrolment is complete" do
          before do
            enrolment = create(:user_programme_enrolment, user: user, programme: primary_certificate)
            enrolment.transition_to(:complete)
          end

          it "enrols user" do
            expect { enrol_job }
              .to change { UserProgrammeEnrolment.where(programme: cs_accelerator).count }
              .by(1)
          end
        end
      end

      context "when user is not enrolled in any programme linked to activity" do
        it "enrols user to csa" do
          expect { enrol_job }
            .to change { UserProgrammeEnrolment.where(programme: cs_accelerator).count }
            .by(1)
        end
      end
    end
  end
end

require "rails_helper"

RSpec.describe KickOffEmailsJob, type: :job do
  let(:primary_certificate) { create(:primary_certificate) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:secondary) { create(:secondary_certificate) }
  let(:i_belong) { create(:i_belong) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, programme: cs_accelerator) }
  let(:i_belong_enrolment) { create(:user_programme_enrolment, programme: i_belong) }
  let(:secondary_enrolment) { create(:user_programme_enrolment, programme: secondary) }
  let(:primary_certificate_enrolment) { create(:user_programme_enrolment, programme: primary_certificate) }

  let(:auto_enrolled) { create(:user_programme_enrolment, programme: primary_certificate, auto_enrolled: true) }

  describe "#perform" do
    context "when the programme is cs accelerator" do
      it "sends an email" do
        expect { described_class.perform_now(cs_accelerator_enrolment.id) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when the programme is I Belong" do
      it "sends an email with the correct subject" do
        expect { described_class.perform_now(i_belong_enrolment.id) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(ActionMailer::Base.deliveries.last.subject).to eq "Welcome to I Belong: Encouraging girls into computer science!"
      end
    end

    context "when the programme is primary" do
      it "sends an email" do
        expect { described_class.perform_now(primary_certificate_enrolment.id) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when the programme is secondary" do
      it "sends an email with the correct subject" do
        expect { described_class.perform_now(secondary_enrolment.id) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(ActionMailer::Base.deliveries.last.subject).to eq "Welcome to Teach secondary computing"
      end
    end

    describe "prompt jobs to be delivered a month after enrolment" do
      let(:now_time) { Time.new(2020, 11, 11, 12, 22) }
      before do
        allow(Time).to receive(:now).and_return(now_time)
      end

      it "enques jobs to be delivered later" do
        expect do
          described_class.perform_now(cs_accelerator_enrolment.id)
        end.to have_enqueued_job(ScheduleProgrammeGettingStartedPromptJob).with(cs_accelerator_enrolment.id).at(Time.new(2020, 12, 11, 22, 51, 6))

        expect do
          described_class.perform_now(primary_certificate_enrolment.id)
        end.to have_enqueued_job(ScheduleProgrammeGettingStartedPromptJob).with(primary_certificate_enrolment.id).at(Time.new(2020, 12, 11, 22, 51, 6))

        expect do
          described_class.perform_now(i_belong_enrolment.id)
        end.to have_enqueued_job(ScheduleIBelongStudentSurveyPromptJob).with(i_belong_enrolment.user).at(now_time + 1.week)
      end

      it "when not i_belong does not enqueue the i_belong job" do
        expect do
          described_class.perform_now(primary_certificate_enrolment.id)
        end.not_to have_enqueued_job(ScheduleIBelongStudentSurveyPromptJob)
        expect do
          described_class.perform_now(cs_accelerator_enrolment.id)
        end.not_to have_enqueued_job(ScheduleIBelongStudentSurveyPromptJob)
        expect do
          described_class.perform_now(secondary_enrolment.id)
        end.not_to have_enqueued_job(ScheduleIBelongStudentSurveyPromptJob)
      end
    end

    describe "with auto enrolment" do
      it "should send auto enrolled email" do
        expect {
          described_class.perform_now(auto_enrolled.id)
        }.to have_enqueued_mail(PrimaryMailer, :auto_enrolled).with(a_hash_including(params: {user: auto_enrolled.user}))
      end

      it "should scheudle for 9am if in the morning" do
        now = DateTime.now.change(hour: 1)
        travel_to(now) do
          expect {
            described_class.perform_now(auto_enrolled.id)
          }.to have_enqueued_mail(PrimaryMailer, :auto_enrolled).with(a_hash_including(params: {user: auto_enrolled.user})).at(now.change(hour: 9))
        end
      end
    end
  end
end

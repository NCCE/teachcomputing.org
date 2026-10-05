require "rails_helper"

RSpec.describe CompletedCpdButNotActivitiesJob, type: :job do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let!(:enrolment) { create(:user_programme_enrolment, user:, programme:) }
  let(:mailer_type) { PrimaryMailer::COMPLETED_CPD_NOT_ACTIVITIES_EMAIL }
  let(:sent_email) { SentEmail.find_by(user:, mailer_type:) }

  before do
    allow_any_instance_of(Programmes::PrimaryCertificate)
      .to receive(:user_completed_cpd_not_community?).with(user).and_return(true)
  end

  def perform
    described_class.perform_now(user.id, programme.id)
  end

  def create_sent_email(send_count:, last_sent_at:)
    create(:sent_email, user:, mailer_type:, send_count:, last_sent_at:)
  end

  describe "#perform" do
    context "when the user is eligible and has never been sent the email" do
      it "sends the email" do
        expect { perform }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "records the first send" do
        freeze_time do
          perform
          expect(sent_email).to have_attributes(
            send_count: 1,
            last_sent_at: Time.current,
            subject: ActionMailer::Base.deliveries.last.subject
          )
        end
      end
    end

    context "when the user is not eligible" do
      before do
        allow_any_instance_of(Programmes::PrimaryCertificate)
          .to receive(:user_completed_cpd_not_community?).with(user).and_return(false)
      end

      it "does not send" do
        expect { perform }.not_to change { ActionMailer::Base.deliveries.count }
      end
    end

    it "does not send when the user has no enrolment" do
      enrolment.destroy
      expect { perform }.not_to change { ActionMailer::Base.deliveries.count }
    end

    it "does not send when the user has unenrolled" do
      enrolment.transition_to(:unenrolled)
      expect { perform }.not_to change { ActionMailer::Base.deliveries.count }
    end

    it "does not send when the enrolment is pending" do
      enrolment.transition_to(:pending)
      expect { perform }.not_to change { ActionMailer::Base.deliveries.count }
    end

    it "sends again once a re-enrolled user is eligible" do
      enrolment.transition_to(:unenrolled)
      enrolment.transition_to(:enrolled)
      expect { perform }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    context "when the email was sent less than 3 months ago" do
      before { create_sent_email(send_count: 1, last_sent_at: 2.months.ago) }

      it "does not send" do
        expect { perform }.not_to change { ActionMailer::Base.deliveries.count }
      end
    end

    context "when the email was sent 3 or more months ago" do
      before { create_sent_email(send_count: 1, last_sent_at: 3.months.ago) }

      it "sends again and increments the count" do
        expect { perform }.to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(sent_email.send_count).to eq 2
      end
    end

    context "when the last send was at the end of a long month" do
      it "sends once 3 calendar months have passed" do
        last_sent_at = Time.zone.parse("2026-11-30 10:00")
        create_sent_email(send_count: 1, last_sent_at:)

        travel_to(last_sent_at + 3.months) do
          expect { perform }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end
    end

    context "when this is the fourth send" do
      before { create_sent_email(send_count: 3, last_sent_at: 4.months.ago) }

      it "sends" do
        expect { perform }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when 4 emails have already been sent" do
      before { create_sent_email(send_count: 4, last_sent_at: 4.months.ago) }

      it "does not send" do
        expect { perform }.not_to change { ActionMailer::Base.deliveries.count }
      end
    end

    context "when delivery fails" do
      before do
        allow(PrimaryMailer).to receive(:with).and_raise(Net::SMTPServerBusy.new(nil, message: "busy"))
      end

      it "does not count the attempt, so the next run sends" do
        expect { perform }.to raise_error(Net::SMTPServerBusy)
        expect(sent_email).to be_nil

        allow(PrimaryMailer).to receive(:with).and_call_original
        expect { perform }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "with the secondary certificate" do
      let(:programme) { create(:secondary_certificate) }
      let(:mailer_type) { SecondaryMailer::COMPLETED_CPD_NOT_ACTIVITIES_EMAIL }

      before do
        allow_any_instance_of(Programmes::SecondaryCertificate)
          .to receive(:user_completed_cpd_not_community?).with(user).and_return(true)
      end

      it "sends and records against the secondary mailer type" do
        expect { perform }.to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(sent_email.send_count).to eq 1
      end
    end
  end
end

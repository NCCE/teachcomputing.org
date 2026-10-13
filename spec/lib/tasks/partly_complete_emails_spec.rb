require "rails_helper"

RSpec.describe "rake partly_complete_emails:send", type: :task do
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:secondary_certificate) { create(:secondary_certificate) }
  let(:user) { create(:user) }

  it "queues the job for a user enrolled on the primary certificate" do
    create(:user_programme_enrolment, user:, programme: primary_certificate)

    expect { task.execute }
      .to have_enqueued_job(CompletedCpdButNotActivitiesJob).with(user.id, primary_certificate.id).exactly(:once)
  end

  it "queues the job for a user enrolled on the secondary certificate" do
    create(:user_programme_enrolment, user:, programme: secondary_certificate)

    expect { task.execute }
      .to have_enqueued_job(CompletedCpdButNotActivitiesJob).with(user.id, secondary_certificate.id).exactly(:once)
  end

  it "queues the job once per certificate for a user enrolled on both" do
    create(:user_programme_enrolment, user:, programme: primary_certificate)
    create(:user_programme_enrolment, user:, programme: secondary_certificate)

    expect { task.execute }.to have_enqueued_job(CompletedCpdButNotActivitiesJob).exactly(:twice)
  end

  it "does not queue the job for a user who has unenrolled" do
    create(:user_programme_enrolment, user:, programme: primary_certificate).transition_to(:unenrolled)

    expect { task.execute }.not_to have_enqueued_job(CompletedCpdButNotActivitiesJob)
  end

  it "does not queue the job for enrolments on other programmes" do
    create(:user_programme_enrolment, user:, programme: create(:cs_accelerator))

    expect { task.execute }.not_to have_enqueued_job(CompletedCpdButNotActivitiesJob)
  end
end

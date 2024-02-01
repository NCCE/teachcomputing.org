require "rails_helper"

RSpec.describe AutoEnrolJob, type: :job do
  context "when the user is ellible to be enrolled on the activities programmes" do
    it "should try to enrol the user to all of them" do
      user = create(:user)

      secondary_certificate = create(:secondary_certificate)
      primary_certificate = create(:primary_certificate)

      activity = create(:activity)
      create(:programme_activity, activity:, programme: secondary_certificate)
      create(:programme_activity, activity:, programme: primary_certificate)

      achievement = create(:achievement, user:, activity:)

      callable = double(:callable)
      allow(callable).to receive(:call)

      expect(Programmes::UserEnroller).to receive(:new).twice.and_return(callable)

      AutoEnrolJob.perform_now(achievement:)
    end
  end

  context "when one of the programmes is not auto-enrollable" do
    it "should be skipped" do
      user = create(:user)

      secondary_certificate = create(:secondary_certificate)
      primary_certificate = create(:primary_certificate)

      activity = create(:activity)
      create(:programme_activity, activity:, programme: secondary_certificate)
      create(:programme_activity, activity:, programme: primary_certificate)

      achievement = create(:achievement, user:, activity:)

      allow_any_instance_of(Programmes::PrimaryCertificate).to receive(:auto_enrollable?).and_return(false)

      callable = double(:callable)
      allow(callable).to receive(:call)

      expect(Programmes::UserEnroller).to receive(:new).with(
        programme_id: secondary_certificate.id,
        pathway_slug: secondary_certificate.pathways.first.slug,
        user_id: user.id,
        auto_enrolled: true
      ).and_return(callable)

      AutoEnrolJob.perform_now(achievement:)
    end
  end

  context "when the user is already enrolled in one of the programmes" do
    it "should skip that programme" do
      user = create(:user)

      secondary_certificate = create(:secondary_certificate)
      primary_certificate = create(:primary_certificate)

      activity = create(:activity)
      create(:programme_activity, activity:, programme: secondary_certificate)
      create(:programme_activity, activity:, programme: primary_certificate)

      achievement = create(:achievement, user:, activity:)

      allow_any_instance_of(Programmes::PrimaryCertificate).to receive(:user_enrolled?).and_return(true)

      callable = double(:callable)
      allow(callable).to receive(:call)

      expect(Programmes::UserEnroller).to receive(:new).with(
        programme_id: secondary_certificate.id,
        pathway_slug: secondary_certificate.pathways.first.slug,
        user_id: user.id,
        auto_enrolled: true
      ).and_return(callable)

      AutoEnrolJob.perform_now(achievement:)
    end
  end

  context "when the stem activity code is ignored by the particular certificate" do
    it "should skip that programme" do
      user = create(:user)

      secondary_certificate = create(:secondary_certificate)
      primary_certificate = create(:primary_certificate)

      activity = create(:activity)
      create(:programme_activity, activity:, programme: secondary_certificate)
      create(:programme_activity, activity:, programme: primary_certificate)

      achievement = create(:achievement, user:, activity:)

      allow_any_instance_of(Programmes::PrimaryCertificate).to receive(:auto_enrollment_ignored_activity_codes)
        .and_return([activity.stem_activity_code])

      callable = double(:callable)
      allow(callable).to receive(:call)

      expect(Programmes::UserEnroller).to receive(:new).with(
        programme_id: secondary_certificate.id,
        pathway_slug: secondary_certificate.pathways.first.slug,
        user_id: user.id,
        auto_enrolled: true
      ).and_return(callable)

      AutoEnrolJob.perform_now(achievement:)
    end
  end

  context "when the achievement is a community activity" do
    it "should not enroll any of the related programmes" do
      user = create(:user)

      secondary_certificate = create(:secondary_certificate)
      primary_certificate = create(:primary_certificate)

      activity = create(:activity, :community)
      create(:programme_activity, activity:, programme: secondary_certificate)
      create(:programme_activity, activity:, programme: primary_certificate)

      achievement = create(:achievement, user:, activity:)

      expect(Programmes::UserEnroller).not_to receive(:new)

      AutoEnrolJob.perform_now(achievement:)
    end
  end
end

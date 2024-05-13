require "rails_helper"

RSpec.describe "rake vital_model_checker", type: :task do
  before do
    allow(Sentry).to receive(:capture_message)
  end

  it "should call sentry if no Achievements" do
    task.execute
    expect(Sentry).to have_received(:capture_message).twice
  end

  describe "with face to face achievement" do
    describe "created recently" do
      before do
        create(:achievement, :face_to_face)
      end

      it "should only call sentry once for online" do
        task.execute
        expect(Sentry).to have_received(:capture_message).once.with("No online achievements created at in the last 24 hours.")
      end
    end
    describe "created a while ago" do
      before do
        create(:achievement, :face_to_face, created_at: 2.days.ago)
      end

      it "should call sentry twice" do
        task.execute
        expect(Sentry).to have_received(:capture_message).twice
      end
    end
  end

  describe "with online achievement" do
    describe "created recently" do
      before do
        create(:achievement, :online)
      end

      it "should only call sentry once for face to face" do
        task.execute
        expect(Sentry).to have_received(:capture_message).once.with("No face to face achievements created at in the last 24 hours.")
      end
    end
    describe "created a while ago" do
      before do
        create(:achievement, :online, created_at: 2.days.ago)
      end

      it "should call sentry twice" do
        task.execute
        expect(Sentry).to have_received(:capture_message).twice
      end
    end
  end
end

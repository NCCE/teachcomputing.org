require "rails_helper"

RSpec.describe OnlineBookingPresenter do
  describe "title" do
    it { expect(described_class.new.title).to eq("Join this course") }
  end

  describe "authenticated_title" do
    it { expect(described_class.new.authenticated_title).to eq("Join this course") }
  end

  describe "enrolled_title" do
    it { expect(described_class.new.enrolled_title).to eq("You are enrolled on this course") }
  end

  describe "completed_title" do
    it { expect(described_class.new.completed_title).to eq("You've completed this course") }
  end

  context "when the course has not started yet" do
    let(:course_started) { false }

    describe "#enrolled_introduction" do
      it "asks to check your email" do
        introduction = described_class.new.enrolled_introduction(course_started)

        expect(Nokogiri::HTML(introduction).content)
          .to match(
            /Check your email for further details about your course booking\..*Not received an email confirmation\? Contact info@teachcomputing.org\./m
          )
      end
    end

    describe "#enrolled_button_title" do
      it "is nil because no button should appear" do
        expect(described_class.new.enrolled_button_title(course_started)).to be_nil
      end
    end
  end

  context "when the course has already started" do
    let(:course_started) { true }

    describe "#enrolled_introduction" do
      it "explains where the course is" do
        introduction = described_class.new.enrolled_introduction(course_started)
        expect(Nokogiri::HTML(introduction).content)
          .to match(
            /You will be taken to the MyLearning platform for further details./m
          )
      end
    end

    describe "#enrolled_button_title" do
      it { expect(described_class.new.enrolled_button_title(course_started)).to eq("Continue on MyLearning") }
    end
  end

  describe "introduction" do
    it { expect(described_class.new.introduction).to eq("You will be taken to the STEM Learning website to enrol onto the online course.") }
  end

  describe "unauthenticated_booking_button_title" do
    it { expect(described_class.new.unauthenticated_booking_button_title).to eq("Login to join") }
  end

  describe "completed_button_title" do
    it { expect(described_class.new.completed_button_title).to eq("Visit MyLearning") }
  end

  describe "completed_button_introduction" do
    it { expect(described_class.new.completed_button_introduction).to eq("You will be taken to the MyLearning platform for further details.") }
  end

  describe "#booking_path" do
    context "when the CPD store is enabled" do
      before { allow(Rails.application.config).to receive(:stem_cpd_store_enabled).and_return(true) }

      it "is the full URI of the CPD store booking" do
        expect(
          described_class.new.booking_path("FAKE_COURSE_ID", "FAKE_ACTIVITY_CODE")
        ).to eq "#{ENV.fetch("STEM_CPD_STORE_REDIRECT")}/course/FAKE_ACTIVITY_CODE"
      end
    end

    context "when the CPD store is disabled" do
      before { allow(Rails.application.config).to receive(:stem_cpd_store_enabled).and_return(false) }

      it "is the full URI of the legacy STEM Learning booking" do
        expect(
          described_class.new.booking_path("FAKE_COURSE_ID", "FAKE_ACTIVITY_CODE")
        ).to eq "#{ENV.fetch("STEM_COURSE_REDIRECT")}/cpdredirect/FAKE_COURSE_ID"
      end
    end
  end
end

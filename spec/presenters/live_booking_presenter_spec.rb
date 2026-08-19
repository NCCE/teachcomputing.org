require "rails_helper"

RSpec.describe LiveBookingPresenter do
  let(:course) { Achiever::Course::Template.find_by_activity_code("CP448") } # a live course with online_cpd: false

  describe "#title" do
    it { expect(described_class.new.title).to eq("Book this course") }
  end

  describe "#authenticated_title" do
    it { expect(described_class.new.authenticated_title).to eq("Book this course") }
  end

  describe "#enrolled_title" do
    it { expect(described_class.new.enrolled_title).to eq("You’re booked on this course") }
  end

  describe "#completed_title" do
    it { expect(described_class.new.completed_title).to eq("You’ve completed this course") }
  end

  describe "#introduction" do
    it { expect(described_class.new.introduction).to eq("You will be taken to the STEM Learning website to see further details.") }
  end

  describe "#no_occurrences_introduction" do
    it { expect(described_class.new.no_occurrences_introduction).to eq("Keep an eye on our social media for new courses announcements coming soon!") }
  end

  describe "#enrolled_introduction" do
    it "is not implemented" do
      expect { described_class.new.enrolled_introduction(nil) }.to raise_error(NotImplementedError)
    end
  end

  describe "#unauthenticated_booking_button_title" do
    it { expect(described_class.new.unauthenticated_booking_button_title).to eq("Login to book this course") }
  end

  describe "#booking_button_title" do
    it { expect(described_class.new.booking_button_title).to eq("Book") }
  end

  describe "#enrolled_button_title" do
    it "is not implemented" do
      expect { described_class.new.enrolled_button_title(nil) }.to raise_error(NotImplementedError)
    end
  end

  describe "#activity_date" do
    it "reformats a date and time string" do
      expect(described_class.new.activity_date("01/06/2023 10:30:55", "01/06/1023 16:30:55")).to eq "1st June 2023, Thursday 10:30"
    end
  end

  describe "#booking_path" do
    context "when the CPD store is enabled" do
      before { allow(Rails.application.config).to receive(:stem_cpd_store_enabled).and_return(true) }

      it "is the full URI of the CPD store booking when there is no specific occurrence" do
        expect(
          described_class.new.booking_path(course_template_no: "FAKE_TEMPLATE_ID")
        ).to eq "#{ENV.fetch("STEM_CPD_STORE_URL")}/course/FAKE_TEMPLATE_ID"
      end

      it "includes the occurrence id as an instance query param when given" do
        expect(
          described_class.new.booking_path(course_template_no: "FAKE_TEMPLATE_ID", occurrence_id: "FAKE_OCCURRENCE_ID")
        ).to eq "#{ENV.fetch("STEM_CPD_STORE_URL")}/course/FAKE_TEMPLATE_ID?instance=FAKE_OCCURRENCE_ID"
      end
    end

    context "when the CPD store is disabled" do
      before { allow(Rails.application.config).to receive(:stem_cpd_store_enabled).and_return(false) }

      it "is the full URI of the legacy STEM Learning booking using the occurrence id" do
        expect(
          described_class.new.booking_path(course_template_no: "FAKE_TEMPLATE_ID", occurrence_id: "FAKE_OCCURRENCE_ID")
        ).to eq "#{ENV.fetch("STEM_COURSE_REDIRECT")}/cpdredirect/FAKE_OCCURRENCE_ID"
      end

      it "falls back to the course template no when there is no specific occurrence" do
        expect(
          described_class.new.booking_path(course_template_no: "FAKE_TEMPLATE_ID")
        ).to eq "#{ENV.fetch("STEM_COURSE_REDIRECT")}/cpdredirect/FAKE_TEMPLATE_ID"
      end
    end
  end

  describe "#address" do
    let(:occurrence) {
      OpenStruct.new(
        {
          address_venue_name: "The Crucible",
          address_town: "Sheffield",
          address_postcode: "S12 8AB"
        }
      )
    }

    it "is a one-line location for on-site course" do
      expect(described_class.new.address(occurrence))
        .to eq("The Crucible, Sheffield, S12 8AB")
    end

    it 'says "Live remote training" if remotely delivered' do
      occurrence.remote_delivered_cpd = true
      expect(described_class.new.address(occurrence))
        .to eq("Live remote training")
    end
  end

  describe "#show_stem_occurrence_list" do
    it "is true" do
      expect(described_class.new.show_stem_occurrence_list(nil)).to be true
    end
  end
end

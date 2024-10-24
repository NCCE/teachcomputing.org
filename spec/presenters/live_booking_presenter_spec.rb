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
    it { expect(described_class.new.no_occurrences_introduction).to eq("Contact your local Computing Hub for more information") }
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

  describe "#completed_button_introduction" do
    it "is not implemented" do
      expect { described_class.new.completed_button_introduction }.to raise_error(NotImplementedError)
    end
  end

  describe "#completed_button_title" do
    it "is not implemented" do
      expect { described_class.new.completed_button_title }.to raise_error(NotImplementedError)
    end
  end

  describe "#activity_date" do
    it "reformats a date and time string" do
      expect(described_class.new.activity_date("01/06/2023 10:30:55", "01/06/1023 16:30:55")).to eq "1st June 2023, Thursday 10:30"
    end
  end

  describe "#course_button" do
    context "when no occurrences" do
      it "links to the course booking path" do
        expect(
          described_class.new.course_button([], "FAKE_COURSE_ID")
        ).to match(/href="https:\/\/ncce-www-stage-int.stem.org.uk\/cpdredirect\/FAKE_COURSE_ID"/)
      end

      it 'says "View course"' do
        expect(
          described_class.new.course_button([], "FAKE_COURSE_ID")
        ).to match(/>View course<\/a>/)
      end
    end

    context "when 20 occurrences" do
      it "links to the course booking path" do
        expect(
          described_class.new.course_button(Array.new(20), "FAKE_COURSE_ID")
        ).to match(/href="https:\/\/ncce-www-stage-int.stem.org.uk\/cpdredirect\/FAKE_COURSE_ID"/)
      end

      it 'says "See more dates"' do
        expect(
          described_class.new.course_button(Array.new(20), "FAKE_COURSE_ID")
        ).to match(/>See more dates<\/a>/)
      end
    end

    context "when < 20 occurrences" do
      it "is nil" do
        expect(
          described_class.new.course_button(Array.new(19), "FAKE_COURSE_ID")
        ).to be_nil
      end
    end
  end

  describe "#booking_path" do
    it "is the full URI of the stem website booking" do
      expect(
        described_class.new.booking_path("FAKE_COURSE_ID")
      ).to eq "https://ncce-www-stage-int.stem.org.uk/cpdredirect/FAKE_COURSE_ID"
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

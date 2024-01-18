require "rails_helper"

RSpec.describe Achiever::Course::Template do
  let(:course_template) { described_class.all.first }

  describe "accessor methods" do
    before do
      stub_course_templates
    end

    it "provides the required accessor methods" do
      expect(course_template).to respond_to(:activity_code)
      expect(course_template).to respond_to(:age_groups)
      expect(course_template).to respond_to(:booking_url)
      expect(course_template).to respond_to(:course_leaders)
      expect(course_template).to respond_to(:course_template_no)
      expect(course_template).to respond_to(:duration_unit)
      expect(course_template).to respond_to(:duration_value)
      expect(course_template).to respond_to(:how_long_is_the_course)
      expect(course_template).to respond_to(:how_will_you_learn)
      expect(course_template).to respond_to(:meta_description)
      expect(course_template).to respond_to(:occurrences)
      expect(course_template).to respond_to(:online_cpd)
      expect(course_template).to respond_to(:outcomes)
      expect(course_template).to respond_to(:programmes)
      expect(course_template).to respond_to(:remote_delivered_cpd)
      expect(course_template).to respond_to(:subjects)
      expect(course_template).to respond_to(:summary)
      expect(course_template).to respond_to(:title)
      expect(course_template).to respond_to(:topics_covered)
      expect(course_template).to respond_to(:who_is_it_for)
      expect(course_template).to respond_to(:workstream)
    end
  end

  describe "constants" do
    describe "RESOURCE_PATH" do
      it "is not nil" do
        expect(Achiever::Course::Template::RESOURCE_PATH).not_to eq nil
      end
    end

    describe "QUERY_STRINGS" do
      it "contains page" do
        expect(Achiever::Course::Template::QUERY_STRINGS).to have_key(:Page)
      end

      it "contains record count" do
        expect(Achiever::Course::Template::QUERY_STRINGS).to have_key(:RecordCount)
      end

      it "contains hide from web" do
        expect(Achiever::Course::Template::QUERY_STRINGS).to have_key(:HideFromweb)
      end
    end

    describe "TS_PROGRAMME_MAPPING" do
      it "maps Subject Knowledge" do
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING).to have_key("CS Accelerator")
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING["CS Accelerator"]).to eq("subject-knowledge")
      end

      it "maps Subject Knowledge duplicated" do
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING).to have_key("CS Accelerator")
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING["CS Accelerator"]).to eq("subject-knowledge")
      end

      it "maps Primary Certificate" do
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING).to have_key("Primary")
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING["Primary"]).to eq("primary-certificate")
      end

      it "maps Secondary Certificate" do
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING).to have_key("Secondary")
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING["Secondary"]).to eq("secondary-certificate")
      end

      it "maps I Belong" do
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING).to have_key("I Belong")
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING["I Belong"]).to eq("i-belong")
      end

      it "maps A Level" do
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING).to have_key("A Level")
        expect(Achiever::Course::Template::TS_PROGRAMME_MAPPING["A Level"]).to eq("a-level-certificate")
      end
    end
  end

  describe ".all" do
    before do
      stub_course_templates
    end

    it "returns an array" do
      expect(described_class.all).to be_an Array
    end

    it "the array contains Achiever::Course::Template objects" do
      expect(described_class.all.sample).to be_an described_class
    end
  end

  describe ".find_by_activity_code" do
    before do
      stub_course_templates
    end

    context "when a template exists" do
      it "returns the Achiever::Course::Template instance" do
        expect(described_class.find_by_activity_code("CP228")).to be_an described_class
      end
    end

    context "when a template does not exists" do
      it "raises a 404 exception" do
        expect { described_class.find_by_activity_code("111") }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe ".find_many_by_activity_codes" do
    before do
      stub_course_templates
    end

    context "when templates exist" do
      it "returns the Achiever::Course::Template instance" do
        results = described_class.find_many_by_activity_codes(%w[CP228 CP428])
        expect(results).to be_an(Array)
        expect(results).to all(be_an(described_class))
      end
    end

    context "when template do not exist" do
      it "returns an empty array" do
        expect(described_class.find_many_by_activity_codes(%w[111 222])).to eq([])
      end
    end
  end

  describe "#by_certificate" do
    before do
      stub_age_groups
      stub_course_templates
    end

    context "when the programme is cs accelerator" do
      it "returns true when the template is part of the programme" do
        template = described_class.all.first
        expect(template.by_certificate("subject-knowledge")).to eq true
      end
    end

    context "when the template is not part of the programme" do
      it "returns false" do
        template = described_class.all.second
        expect(template.by_certificate("primary-certificate")).to eq false
      end
    end
  end

  describe "#duration" do
    before do
      stub_duration_units
      stub_age_groups
      stub_course_templates
    end

    it "returns the duration unit value" do
      expect(described_class.all.second.duration).to eq "Hours"
    end
  end

  describe "#duration_present?" do
    before do
      stub_duration_units
      stub_course_templates
    end

    context "when present" do
      it "is true" do
        expect(described_class.all.second.duration_present?).to be true
      end
    end

    context "when absent" do
      it "is false" do
        expect(described_class.maybe_find_by_activity_code("cp007").duration_present?).to be false
      end
    end
  end

  describe "#formatted_duration" do
    before do
      stub_duration_units
      stub_course_templates
    end

    it "is pluralized correctly" do
      expect(described_class.maybe_find_by_activity_code("cp428")
               .formatted_duration)
        .to eq "5 hours"
    end

    it "is singular when needed" do
      expect(described_class.maybe_find_by_activity_code("cp228")
               .formatted_duration)
        .to eq "1 day"
    end

    it "is empty when source data missing" do
      expect(described_class.maybe_find_by_activity_code("cp007")
               .formatted_duration)
        .to eq ""
    end
  end

  describe "#with_occurrences" do
    before do
      stub_course_templates
      stub_face_to_face_occurrences
    end

    it "returns a collection of with_occurrences" do
      expect(described_class.all.first.with_occurrences).to be_a(Array)
    end
  end

  describe "#nearest_occurrence_distance" do
    context "when occurrences have distances" do
      it "returns the smallest distance value" do
        occ1 = build(:achiever_course_occurrence, distance: 90)
        occ2 = build(:achiever_course_occurrence, distance: 20)
        occ3 = build(:achiever_course_occurrence, distance: 60)
        template = build(:achiever_course_template, occurrences: [occ1, occ2, occ3])
        expect(template.nearest_occurrence_distance).to eq(20)
      end
    end

    context "when not all occurrences have distances" do
      it "returns the smallest distance value" do
        occ1 = build(:achiever_course_occurrence, distance: 90)
        occ2 = build(:achiever_course_occurrence, distance: nil)
        occ3 = build(:achiever_course_occurrence, distance: 60)
        template = build(:achiever_course_template, occurrences: [occ1, occ2, occ3])
        expect(template.nearest_occurrence_distance).to eq(60)
      end
    end

    context "when no occurrences have distances" do
      it "returns nil" do
        occ1 = build(:achiever_course_occurrence, distance: nil)
        occ2 = build(:achiever_course_occurrence, distance: nil)
        template = build(:achiever_course_template, occurrences: [occ1, occ2])
        expect(template.nearest_occurrence_distance).to eq(nil)
      end
    end

    context "when template has no occurrences" do
      it "returns nil" do
        template = build(:achiever_course_template)
        expect(template.nearest_occurrence_distance).to eq(nil)
      end
    end
  end
end

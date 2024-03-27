require "rails_helper"

RSpec.describe Achiever::Request do
  let(:option_set_query_strings) { Achiever::Course::AgeGroup::QUERY_STRINGS }
  let(:template_query_strings) { Achiever::Course::Template::QUERY_STRINGS.merge(ProgrammeName: "ncce") }
  let(:successful_json_response) { File.read("spec/support/achiever/courses/face_to_face_occurrences.json") }
  let(:successful_parsed_response) { described_class.send(:parse_response, successful_json_response) }
  let(:unsuccessful_json_response) { File.read("spec/support/achiever/failure.json") }
  let(:unsuccessful_parsed_response) { described_class.send(:parse_response, unsuccessful_json_response) }

  describe "class methods" do
    describe "#option_sets" do
      it "returns an String" do
        stub_age_groups
        expect(described_class.option_sets("Get?cmd=OptionsetAgeGroups", option_set_query_strings)).to be_a String
      end

      context "when unsuccessful" do
        it "raises an Achiever::Error exception" do
          stub_a_failed_response("OptionsetAgeGroups", option_set_query_strings)
          expect do
            described_class.option_sets("Get?cmd=OptionsetAgeGroups", option_set_query_strings)
          end.to raise_error(Achiever::Error)
        end
      end
    end

    describe "#resource" do
      it "returns an Array" do
        stub_course_templates
        expect(described_class.resource(
          "Get?cmd=CourseTemplatesListingByProgramme",
          template_query_strings
        ))
          .to be_a Array
      end

      context "when unsuccessful" do
        it "returns an empty array" do
          stub_a_failed_response("CourseTemplatesListingByProgramme", template_query_strings)
          expect(described_class.resource(
            "Get?cmd=CourseTemplatesListingByProgramme",
            template_query_strings
          ))
            .to eq([])
        end
      end

      context "when json parsing errors" do
        it "returns an empty array" do
          stub_an_html_error_page("CourseTemplatesListingByProgramme", template_query_strings)
          expect(described_class.resource(
            "Get?cmd=CourseTemplatesListingByProgramme",
            template_query_strings
          ))
            .to eq([])
        end
      end
    end
  end
end
